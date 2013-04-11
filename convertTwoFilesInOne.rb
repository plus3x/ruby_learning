class TestConvertTwoFilesInToOne
  def test
    set_test_simple_data
    
    create_test_files

    if !class_exist? 
      puts "Class doen't exist!"
    else
      if !output_file_is_exist?
        puts "Output file does't exist!" 
      else
        if !output_file_is_correct?
          puts "Output data is not correct!"
        else
          puts "Test is done! No errors!"
        end
      end
    end

    delete_test_files
  end

  def output_file_is_exist?
    @@output_file_name != nil ? File.exist?(@@output_file_name) : false
  end

  def class_exist?
    begin
      @@output_file_name = 
	ConvertTwoFilesInToOne.new.convert(@@file1_name, @@file2_name)
    rescue
      false
    end
  end

  def set_test_simple_data
    @@file1_name, @@file2_name = "file1.txt", "file2.txt"
    @@list1_data, @@list2_data = 
	    ["Rob V", "Mike B", "Sten J"], ["Bobby N", "Mike B", "Cris H"]
    @@true_resoult = 
	    ["Rob V\n", "Mike B\n", "Sten J\n", "Bobby N\n", "Cris H\n"]
    @@file_name = "File variable in function"
  end

  def delete_test_files
    file = @@output_file_name rescue ""
    [@@file1_name, @@file2_name, file].each { |file| 
      File.delete file if File.exist? file }
  end

  def create_test_files
    files = [[@@file1_name, @@list1_data], [@@file2_name, @@list2_data]]
    files.each { |file, data| File.open(file, "w") { |line| line.puts data } }
  end

  def output_file_is_correct?
    @@true_resoult == File.readlines(@@output_file_name)
  end
end

class ConvertTwoFilesInToOne
  def convert(file1_name, file2_name)
    if !files_exist? file1_name, file2_name
      puts "Files or one does't exist!"
      "nil_output"
    else
      get_files_data
      merge_the_files_data_with_the_exception_of_repetitions
      write_data_in_to_output_file
      return_output_file_name
    end
  end

  def files_exist?(file1, file2) 
    File.exist?(@@file1 = file1) and File.exist?(@@file2 = file2)
  end

  def get_files_data
    @@file1_data = File.readlines(@@file1)
    @@file2_data = File.readlines(@@file2) 
  end

  def merge_the_files_data_with_the_exception_of_repetitions
    @@output_data = @@file1_data | @@file2_data
  end

  def write_data_in_to_output_file
    @@output_file = "output.txt"
    File.open(@@output_file, "w") { |line| line.puts @@output_data }
  end

  def return_output_file_name
    @@output_file
  end
end

def clear_screen
 print "\e[2J\e[f"
end

clear_screen
puts "Test class 'ConvertTwoFilesInToOne'"
TestConvertTwoFilesInToOne.new.test
