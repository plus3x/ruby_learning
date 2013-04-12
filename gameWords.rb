class TestGameWords 
  def output_correct?
    input_chain = %w(Bob Mark Karl Lara Yan Buk Kim)
    true_chain = %w(Bob Buk Kim Mark Karl Lara)
    true_chain == GameWords.new(input_chain)
  end
end

class GameWords
  def initialize(chain)
    return %(Chain of words is empty!) if chain == nil
    return %(Chain of words have bad word!) unless chain_is_good? chain
  
    puts "Chains get: #{chains_get chain}"
  end

  def chain_is_good?(chain)
    chain.each { |word| return false unless word[/[a-z]{2,}/i] } != nil
  end

  def chains_get(chain)
    chains = ''
    chain.each { |word_| 
      (chain - [chain[0]]).each { |word| puts %(#{chain[0]} #{word} #{chain[0][/.$/].downcase} #{word[0].downcase})
        (chains << 
	chain[0] << 
	chains_get([word] + 
		   (chain - 
		    [word] - 
		    [chain[0]])) << 
	word) if 
	chain[0][/.$/].downcase == word[0].downcase
      }
    }
  end
end

#puts %(Test: output chain is #{TestGameWords.new.output_correct? ? 'good' : 'bad'}.)
puts %(Call class GameWords)
puts GameWords.new(%w(bm Mark BoB Jamy))
