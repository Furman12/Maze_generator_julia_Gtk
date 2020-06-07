using Images

mutable struct Point
    x::Int64 # vertical
    y::Int64 # horisont
    Point(x, y) = new(x, y)
end

function neighbour(matrix, p, height, weight)
    neighbours = [Point(p.x, p.y+2), # up
                Point(p.x, p.y-2), # down
                Point(p.x-2, p.y), # left
                Point(p.x+2, p.y)] # right
    aim = []
    for i in neighbours
        if 0<i.x<=height && 0<i.y<=weight && matrix[i.x,i.y] == 2
            push!(aim, i)
        end
    end
    if length(aim) != 0 
        rand(aim) 
    else 
        Point(-1,-1)
    end
end

function barrier_breaker(matrix, newp,oldp)
    x = (newp.x + oldp.x) ÷ 2 
    y = (newp.y + oldp.y) ÷ 2
    matrix[x,y] = 1
end

function matrix_generator(height, weight)
    matrix = [ 2(i&j&1) for i in 0:height, j in 0:weight ]
    p = Point(2,2) # стартовая точа
    lifo = [] # пустой массив
    push!(lifo, p)
    while length(lifo) != 0 # пока не опустеет стек
        matrix[p.x,p.y] = 1 # отметим белым посещенную клетку
        newp = neighbour(matrix, p, height, weight) # new point
        # если нет соседей - идём обратно
        if newp.x == newp.y == -1
            p = pop!(lifo)
        else
            push!(lifo, p)
            barrier_breaker(matrix, newp, p)
            p = newp
        end
    end
    matrix[1,2] = 1 # вход
    matrix[height,weight+1] = 1 # выход
    return matrix
end

function maze_image(height, weight)
    lbrt = matrix_generator(height, weight)
    img = Gray.(lbrt)
    Images.save("/Users/romafurman/Semester2/Pakietymatemat/Maze/Maze.png", img)
end
