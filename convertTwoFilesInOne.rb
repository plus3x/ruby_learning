class TestConvertTwoFilesInToOne
  def initialize
    @file1_name, @file2_name = "file1.txt", "file2.txt"
    @list1_data, @list2_data = ["Rob V", "Mike B", "Sten J"], ["Bobby N", "Mike B", "Cris H"]
    @true_resoult = ["Rob V\n", "Mike B\n", "Sten J\n", "Bobby N\n", "Cris H\n"]
  end

  def test
    create_test_files
    check_correct_output_file
    delete_test_files
  end

  def delete_test_files
    [@file1_name, @file2_name, @output_file_name].each { |file| File.delete(file) if File.exist?(file) }
  end

  def create_test_files
    open(@file1_name, 'w') { |line| line.puts @list1_data }
    open(@file2_name, 'w') { |line| line.puts @list2_data }
  end

  def check_correct_output_file
    @output_file_name = ConvertTwoFilesInToOne.new(@file1_name, @file2_name)
    puts "Output name: #{@output_file_name}"
    puts "Output data: #{open(@output_file_name)}"
    if not @true_resoult == File.readlines(@output_file_name)
      puts "Output data is not correct!"
    else
      puts "Test is done! No errors!"
    end
  end
end

class ConvertTwoFilesInToOne
  def initialize(file1_name, file2_name)
    @file1_name = file1_name
    @file2_name = file2_name
    @output_file_name = "output.txt"
 
    if not (File.exist?(@file1_name) and File.exist?(@file2_name))
      return puts %w(Files or one doen't exist!)
      "nil_output"
    end

    get_files_data
    merge_the_files_data_with_the_exception_of_repetitions
    write_data_in_to_output_file
   
    puts "Output name: #{@output_file_name}"
    puts "Output data: #{@output_file_data}"
    @output_file_name
  end

  def get_files_data
    @file1_data = File.readlines(@file1_name)
    @file2_data = File.readlines(@file2_name) 
  end

  def merge_the_files_data_with_the_exception_of_repetitions
    @output_file_data = @file1_data | @file2_data
  end

  def write_data_in_to_output_file
    File.open(@output_file_name, "w") { |line| line.puts @output_file_data }
  end
end

puts "Test class 'ConvertTwoFilesInToOne'"
TestConvertTwoFilesInToOne.new.test
