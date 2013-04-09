class Test_convert_two_files_in_to_one
 def test
  @file1_name, @file2_name = create_test_file1_and_file2

  puts "File names: #{@file1_name}, #{@file2_name}"

  if exist? class: "Convert_two_files_in_to_one" then
   @output_file = Convert_two_files_in_to_one.new.convert(@file1_name, @file2_name)
  else
   puts "Class 'Convert_two_files_in_to_one' does't exist!"
  end
  
  if !exist? file: @output_file then
   puts "Output file does't exist!" 
  end

  if output_file_is_correct? then
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

 def create_test_file1_and_file2
  @file1_name = "file1.txt"
  @file2_name = "file2.txt"
  data_file1 = ["Rob V", "Mike B", "Sten J"]
  data_file2 = ["Bobby N", "Mike B", "Cris H"]
  return file_create(file_name: @file1_name, data: data_file1), file_create(file_name: @file2_name, data: data_file2)
 end

 def file_create(arg = {})
  File.open(arg[:file_name],'w') do |data_file| 
   data_file.puts arg[:data]
  end
  return arg[:file_name]
 end

 def output_file_is_correct?
  true_resault = ["Rob V", "Mike B", "Sten J", "Bobby N", "Cris H"]
  if !exist? file: @output_file 
   return false 
  end
  File.open(@output_fil.to_s, "r") do |line|
   if (!line.readline == true_resault)
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
