class Tree
 def print(center, size)
  @center, @size = center, size
  correction_center
  print_coma
  print_trunk
 end

 def correction_center
  @center += @size * 3 - 1
 end

 def print_coma
  3.times { |i| print_treeangle(up: i, down: @size+(i-1)) }
 end

 def print_trunk
  width = search_width 
  distance = search_distance(width: width)
  1.upto(@size) { |i| print_spaces_and_stars(spaces: distance, stars: width ) }
 end

 def search_width
  @size < 2 ? 1 : 3
 end

 def search_distance( arg = {} )
  @center - ( ( arg[:width] < 2 ? 2 : arg[:width]) % 2 )
 end

 def print_treeangle(arg = {})
  arg[:up].upto(arg[:down]) { |i| print_spaces_and_stars(spaces: @center - i, stars: 1+(i * 2)) }
 end

 def print_spaces_and_stars(arg = {})
  puts (" " * arg[:spaces]) + ("*" * arg[:stars])
 end
end

def clear_screen
 print "\e[2J\e[f"
end

def one_or_more(number)
 number < 1 ? 1 : number
end

def zero_or_more(number)
 number < 0 ? 0 : number
end

def ask_user_center_and_size_of_tree
 puts "Size and center on tree should be more zero and integer!"
 print "Size of tree(min 1): "
 height = one_or_more(gets.to_i)
 print "Center of the tree(the distance from the left side of the screen to the tree)(min 0): "
 center = zero_or_more(gets.to_i)
 return center, height
end

clear_screen
puts "This programm for printing tree."
center, height = ask_user_center_and_size_of_tree
Tree.new.print(center, height)
