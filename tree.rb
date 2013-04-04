class Print_tree

 def initialize
  clear_screen

  center, height = ask_user_center_and_height_of_tree

  print_tree_with center, height
 end

 def clear_screen
  print "\e[2J\e[f"
 end

 def one_or_more(number)
  return number < 1 ? 1 : number
 end

 def ask_user_center_and_height_of_tree
  print "Tree height(always will be multiplied by three): "
  height = one_or_more(gets.to_i)
  print "Center of the tree(the distance from the left side of the screen): "
  center = one_or_more(gets.to_i)
  return center, height
 end

 def print_tree_with(center, height)
  center += height 
  0.upto(height) { |i| puts ( " " * (center - i) + ("*" * (1+(i * 2))) ) }
  2.upto(5) { |i| puts ( " " * (center - i) + ("*" * (1+(i * 2))) ) }
  3.upto(7) { |i| puts ( " " * (center - i) + ("*" * (1+(i * 2))) ) }
  1.upto(3) { |i| puts ( " " * (center - 1) + ("*" * 3) ) }
 end

end

Print_tree.new
