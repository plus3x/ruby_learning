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
          if !output_error_if_not_correct_enter_chain?
	    puts "Not correct chain is back to output!"
	  else
	    puts "Test is done! No errors!"
	  end
	end
      end
    end
  end

  def create_test_chain_of_words
    @@chain_of_words_words = %w(Bob Mark Karl Lara Yan Buk Kim)
    @@chain_of_words_woeds_with_error_sympols = ["a", "a a", "a1a", "@%$*"]
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

class GameWords
  def game(chain_of_words)
    if !chain_of_words_is_not_nil? chain_of_words
      puts "Chain of words is empty!"
    else
      if !chain_of_words_have_symbols_or_numbers_or_spaces? chain_of_words
	puts "Chain of words have symbols or numbers!"
      else
	select_max_lenght_chain_of_words
	return_chain_of_words
      end
    end
  end

  def chain_of_words_is_not_nil?(chain_of_words)
    @@chain_of_words = chain_of_words != nil ? chain_of_words : false
  end

  def chain_of_words_have_symbols_or_numbers_or_spaces?(chain_of_words)
    chain_of_words.each { |word| return false if !word[/[a-z]{2,}/i] }
  end
  
  def select_max_lenght_chain_of_words(chain)
    puts "Data: #{chain}"
    chain.each { |word| puts "#{word} = #{word[0].downcase} #{word[/.$/].downcase}" }
    puts "Chains get: #{@@chains = chains_get chain}"
  end

  def chains_get(chain)
    chains = ""
    (chain - [chain[0]]).each { |word|
        if chain[0][/.$/].downcase == word[0].downcase
           puts "#{chain[0][/.$/].downcase} #{word[0].downcase}"
	   chains << word << chains_get([word] + (chain - [word] - chain[0]))
	end
      }
    }
    chains + " "
  end
		  
  def return_chain_of_words
    @@max_chain_of_words = "Max chain!)"
  end
end

puts "Call class GameWords"
puts GameWords.new.select_max_lenght_chain_of_words(["bm", "Mark", "BoB", "Jamy"])
