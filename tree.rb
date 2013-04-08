class Tree
 
 def initialize
  @center, @height = 1, 1

  clear_screen

  get_data_from_user

  print_tree
 end

 def print_tree
  print_coma
  print_trunk
 end

 def get_data_from_user 
  @center, @height = ask_user_center_and_height_of_tree
  correction_center
 end

 def correction_center
  @center += @height * 3
 end

 def clear_screen
  print "\e[2J\e[f"
 end

 def one_or_more(number)
  number < 1 ? 1 : number
 end

 def ask_user_center_and_height_of_tree
  print "Tree height(always will be multiplied by three): "
  height = one_or_more(gets.to_i)
  print "Center of the tree(the distance from the left side of the screen): "
  center = one_or_more(gets.to_i)
  return center, height
 end

 def print_coma
  3.times { |i| print_treeangle(up: i, down: @height+(i-1)) }
 end

 def print_trunk
  width = search_width 
  distance = search_distance(width: width)
  1.upto(@height) { |i| print_spaces_and_stars(spaces: distance, stars: width ) }
 end

 def search_width
  @height < 2 ? 1 : 3
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

Tree.new
