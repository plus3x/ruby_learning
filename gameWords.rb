class TestGameWords 
  def output_correct?
    input_chain = %w(Bob Mark Karl Lara Yan Buk Kim)
    true_chain = %w(Bob Buk Kim Mark Karl Lara)
    true_chain == GameWords.new.game(input_chain)
  end
end

class GameWords
  def initialize(chain)
    return %(Chain of words is empty!) if chain == nil
    return %(Chain of words have bad word!) if chain.each { |word| return false unless word[/[a-z]{2,}/i] }
  
    puts "Data: #{chain}"
    chain.each { |word| puts "#{word} = #{word[0].downcase} #{word[/.$/].downcase}" }
    puts "Chains get: #{@@chains = chains_get chain}"
  end

  def chains_get(chain)
    chains = ""
    (chain - [chain[0]]).each { |word|
        if chain[0][/.$/].downcase == word[0].downcase
           puts %(#{chain[0][/.$/].downcase} #{word[0].downcase})
	   chains << word << chains_get([word] + (chain - [word] - chain[0]))
	end
      }
    chains + " "
  end
end

puts %(Output chain is: #{TestGameWord.new.output_corrrect?})
puts %(Call class GameWords)
puts GameWords.new(%w(bm Mark BoB Jamy))
