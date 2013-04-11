class TestGameWords
  def test
    create_test_chain_of_words

    if !class_exist?
      puts "Class does't exist!"
    else
      if !output_data_is_not_nil?
	puts "Output data is empty!"
      else
	if !output_data_is_correct?
	  puts "Output data is not correct!"
	else
	  puts "Test is done! No errors!"
	end
      end
    end
  end

  def create_test_chain_of_words
    @@chain_words = %w(Bob Mark Karl Lara Yan Buk Kim)
    @@true_chain = %w(Bob Buk Kim Mark Karl Lara)
  end

  def class_exist?
    @@output = GameWords.new.game @@chain_words rescue false
  end
  
  def output_data_is_not_nil?
    @@output != nil
  end

  def output_data_is_correct?
    @@output == @@true_chain
  end
end
