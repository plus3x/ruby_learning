class Test_convert_two_files_in_to_one
 def test
  file1, file2 = create_test_file1_and_file2
  
  if (class_exist?("Convert_two_files_in_to_one"))
   @output_file = Convert_two_files_in_one.new(file1, file2)
  else
   return "Class 'Convert_two_files_in_to_one' does't exist!"
  end

  if (output_file_is_correct?)
   return "Test is other, all is right!"
  else
   return "Test is other, output data is not correct"
  end
 end

 def create_test_file1_and_file2

 end

 def class_exist?(class_name)
  Object.const_defined?(class_name)
 end

 def output_file_is_correct?

 end
end

def clear_screen
 print "\e[2J\e[f"
end

clear_screen

puts "Test class 'Convert_two_files_in_to_one'"
puts Test_convert_two_files_in_to_one.new.test
