class Print_tree

 def initialize
  clear_screen

  center = ask_user_center_of_tree
  height = ask_user_height_of_tree

  print_tree_with center, height
 end

 def clear_screen
  print "\e[2J\e[f"
 end

 def ask_user_center_of_tree
  print "Center of the tree(the distance from the left side of the screen): "
  return gets.to_i
 end

 def ask_user_height_of_tree
  print "Tree height(always will be multiplied by three): "
  return gets.to_i
 end

 def print_tree_with(center, heigth)
  0.upto(3) { |i| puts ( " " * (center - i) + ("*" * (1+(i * 2))) ) }
  2.upto(5) { |i| puts ( " " * (center - i) + ("*" * (1+(i * 2))) ) }
  3.upto(7) { |i| puts ( " " * (center - i) + ("*" * (1+(i * 2))) ) }
  1.upto(3) {     puts ( " " * (center - 1) + ("*" * 3) ) }
 end

end

Print_tree.new
