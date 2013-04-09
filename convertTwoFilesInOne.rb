class Test_convert_two_files_in_to_one

 def get_test_data
  return "file1.txt", "file2.txt",
   ["Rob V", "Mike B", "Sten J"], ["Bobby N", "Mike B", "Cris H"],
   ["Rob V", "Mike B", "Sten J", "Bobby N", "Cris H"] 
 end

 def test
  @file1_name, @file2_name, @list1_data, @list2_data, @true_resoult = get_test_data
  
  create_test file_name: @file1_name, data_file: @list1_data
  create_test file_name: @file2_name, data_file: @list2_data

  if exist? class: "Convert_two_files_in_to_one" then
   @output_file = Convert_two_files_in_to_one.new.convert(@file1_name, @file2_name)
  else
   puts "Class 'Convert_two_files_in_to_one' does't exist!"
  end
  
  if !exist? file: @output_file then
   puts "Output file does't exist!" 
  end

  if correct? @output_file then
   puts "Test is done!"
  else
   puts "Output data is not correct!"
  end

  delete_test file: @file1_name
  delete_test file: @file2_name
  if exist? file: @output_file then delete_test file: @output_file end
 end

 def delete_test( arg = {} )
  File.delete(arg[:file])
 end

 def exist?(arg = {})
  case
   when arg.has_key?("file") then
    return File.exist?(arg[:file])
   when arg.has_key?("class") then
    return Object.const_defined?(arg[:class])
  end
 end

 def create_test(arg = {})
  File.open(arg[:file_name],'w') do |data_file|
   data_file.puts arg[:data_file]
  end
 end

 def correct?( output_file )
  if !exist? file: output_file 
   return false 
  end
  File.open(output_file.to_s, "r") do |line|
   if (!line.readline == @true_resault)
    return false
   end
  end
  return true
 end
end

class Convert_two_files_in_to_one
 def convert(file1_name, file2_name)
  return "file_out"
 end
end

def clear_screen
 print "\e[2J\e[f"
end

clear_screen
puts "Test class 'Convert_two_files_in_to_one'"
Test_convert_two_files_in_to_one.new.test
