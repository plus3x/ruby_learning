class Test_convert_two_files_in_to_one
 def test
  file1_name, file2_name = create_test_file1_and_file2

  puts "File names: #{file1_name}, #{file2_name}"

  if (class_exist?("Convert_two_files_in_to_one"))
   @output_file = Convert_two_files_in_one.new(file1_name, file2_name)
  else
   return "Class 'Convert_two_files_in_to_one' does't exist!"
  end
  
  if (!@output_file.exist?)
   return "Output file does't exist!" 
  end

  if (output_file_is_correct?)
   return "Test is done!"
  else
   return "Output data is not correct!"
  end
 end

 def create_test_file1_and_file2
  file1_name = "file1.txt"
  file2_name = "file2.txt"
  data_file1 = ["Rob V", "Mike B", "Sten J"]
  data_file2 = ["Bobby N", "Mike B", "Cris H"]
  return file_create(file_name: file1_name, data: data_file1), file_create(file_name: file2_name, data: data_file2)
 end

 def file_create(arg = {})
  File.open(arg[:file_name],'w') do |data_file| 
   data_file.puts arg[:data]
  end
  return arg[:file_name]
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
