include("./my_code.jl")
using Images
using Gtk, ImageView, TestImages
win = GtkWindow("Maze",600,600)

general_box = GtkBox(:v)

str_box = GtkBox(:v)
label = GtkLabel("Maze Generator")
push!(str_box,label)

label = GtkLabel("Heigh:")
push!(str_box,label)

height = GtkEntry()
set_gtk_property!(height,:text,"20")
push!(str_box, height)

label = GtkLabel("Width:")
push!(str_box,label)

weight = GtkEntry()
set_gtk_property!(weight,:text,"20")
push!(str_box, weight)

buttom_box = GtkBox(:h)

b_solve = GtkButton("Solve")
push!(buttom_box,b_solve)
function buttom_solve()
  return 
end
signal_connect(buttom_solve, b_solve, "clicked")


b_close = GtkButton("Close")
push!(buttom_box,b_close)
signal_connect(b_close, :clicked) do widget
  Gtk.destroy(win)
  println("Exit")
end

b_generate = GtkButton("Generate")
push!(buttom_box,b_generate)
function buttom_generate(w)
  maze_image(parse(Int64, get_gtk_property(height,:text,String)), parse(Int64, get_gtk_property(weight,:text,String)))
  frame, c = ImageView.frame_canvas(:auto)
  image = load("/Users/romafurman/Semester2/Pakietymatemat/Maze/Maze.png")
  imshow(c, image)
  push!(general_box, frame)
  print("suka")
end
signal_connect(buttom_generate, b_generate, :clicked)


set_gtk_property!(buttom_box,:spacing,200)

push!(general_box, str_box)
push!(general_box, buttom_box)

push!(win, general_box)
showall(win)