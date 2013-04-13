class TestConvertTwoFilesInToOne
  def initialize
    @file_one_name, @file_two_name = "file_one.txt", "file_two.txt"
    @list1_data, @list2_data = ["Rob V", "Mike B", "Sten J"], ["Bobby N", "Mike B", "Cris H"]
    @true_resoult = ["Rob V\n", "Mike B\n", "Sten J\n", "Bobby N\n", "Cris H\n"]
  end

  def test
    create_test_files
    check_correct_output_file
    delete_test_files
  end

  def delete_test_files
    [@file_one_name, @file_two_name, @file_output_name].each { |file| File.delete(file) if File.exist?(file) }
  end

  def create_test_files
    open(@file_one_name, 'w') { |line| line.puts @list1_data }
    open(@file_two_name, 'w') { |line| line.puts @list2_data }
  end

  def check_correct_output_file
    @file_output_name = ConvertTwoFilesInToOne.new.convert(@file_one_name, @file_two_name)
    if not @true_resoult == open(@file_output_name).readlines
      puts "Output data is not correct!"
    else
      puts "Test is done! No errors!"
    end
  end
end

class ConvertTwoFilesInToOne
  def convert(file_one_name, file_two_name)
    @file_one_name = file_one_name
    @file_two_name = file_two_name
    @file_output_name = "output.txt"
 
    return puts %w(Files or one doen't exist!) if not (File.exist?(@file_one_name) and File.exist?(@file_two_name))

    get_files_data
    merge_the_files_data_with_the_exception_of_repetitions
    write_data_in_to_output_file
   
    @file_output_name
  end

  def get_files_data
    @file_one_data = open(@file_one_name).readlines
    @file_two_data = open(@file_two_name).readlines 
  end

  def merge_the_files_data_with_the_exception_of_repetitions
    @file_output_data = @file_one_data | @file_two_data
  end

  def write_data_in_to_output_file
    open(@file_output_name, "w") { |line| line.puts @file_output_data }
  end
end

puts "Test class 'ConvertTwoFilesInToOne'"
TestConvertTwoFilesInToOne.new.test
