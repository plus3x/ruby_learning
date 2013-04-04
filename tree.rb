class Print_tree

 def initialize
  clear_screen
  print "Whot center of tree: " 
  center = gets.to_i + 5

  print_tree_with center
 end

 def clear_screen
  print "\e[2J\e[f"
 end

 def print_tree_with(center_tree)
  0.upto(3) { |i| puts ( " " * (center_tree - i) + ("*" * (1+(i * 2))) ) }
  2.upto(5) { |i| puts ( " " * (center_tree - i) + ("*" * (1+(i * 2))) ) }
  3.upto(7) { |i| puts ( " " * (center_tree - i) + ("*" * (1+(i * 2))) ) }
  1.upto(3) {     puts ( " " * (center_tree - 1) + ("*" * 3) ) }
 end

end

Print_tree.new
