class TestConvertTwoFilesInToOne

  def test
    set_test_simple_data

    create_test_files
  
    begin
      @@output_file = 
	ConvertTwoFilesInToOne.new.convert(@@file1_name, @@file2_name)
    rescue
      puts "Class doen't exist!"
    end

    if !output_file_is_exist?
      puts "Output file does't exist!" 
    else
      if !output_file_is_correct?
        puts "Output data is not correct!"
      else
        puts "Test is done!"
      end
    end

    puts "Press enter!"
    gets

    delete_test_files
  end

  def output_file_is_exist?
    File.exist? @@output_file
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
    [@@file1_name, @@file2_name, @@output_file].each { |file| 
	    File.delete(file) if File.exist? file }
  end

  def create_test_files
    files = [[@@file1_name, @@list1_data], [@@file2_name, @@list2_data]]
    files.each { |file, data| File.open(file,'w') { |line| line.puts data } }
  end

  def output_file_is_correct?
    @@true_resoult == File.readlines(@@output_file)
  end
end

class ConvertTwoFilesInToOne
  def convert(file1_name, file2_name)
    resoult = ["Rob V\n", "Mike B\n", "Sten J\n", "Bobby N\n", "Cris H\n"] 
    File.open("outputfile.txt", "w") { |line| line.puts resoult }
    "outputfile.txt"
  end
end

def clear_screen
 print "\e[2J\e[f"
end

clear_screen
puts "Test class 'ConvertTwoFilesInToOne'"
TestConvertTwoFilesInToOne.new.test
