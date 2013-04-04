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
  center += height * 3
  print_treeangle( up_size: 0, down_size: height - 1, center: center )
  0.upto(height - 1) { |i| puts ( " " * (center - i) + ("*" * (1+(i * 2))) ) }
  1.upto(height    ) { |i| puts ( " " * (center - i) + ("*" * (1+(i * 2))) ) }
  2.upto(height + 1) { |i| puts ( " " * (center - i) + ("*" * (1+(i * 2))) ) }
  1.upto(height) { |i| puts ( " " * (center - ( height > 2 ? 1 : 0)) + ("*" * (height > 2 ? 3 : 1)) ) }
 end

 def print_treeangle(arg = {})
  up_size, down_size, center = arg[:up_size].to_i, arg[:down_size].to_i, arg[:center].to_i
  up_size.upto(down_size) { |i| puts spaces(center - i) + stars(1+(i * 2)) }
 end

 def spaces(amount)
  return " " * amount
 end

 def stars(amount)
  return "*" * amount
 end

end


Print_tree.new
