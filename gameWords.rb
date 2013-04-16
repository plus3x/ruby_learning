class TestGameWords 
  def output_correct?
    input_chain = %w(Bob Mark Karl Lara Yan Buk Kim)
    correct_chain = %w(Bob Buk Kim Mark Karl Lara)
    correct_chain == GameWords.new(input_chain)
  end
end

class GameWords
  def longest(chain)
    return %(Chain of words is empty!) if chain == nil
    return %(Chain of words have bad word!) unless chain_is_good? chain

    @chain_longest = ''
    longest_chain chain
    @chain_longest
  end

  def chain_is_good?(chain)
    chain.each { |word| return false if not (word[/[a-z]{2,}/i] and chain.find(word)) }
  end

  def longest_chain(chain, base_word = '')
    chain_return = base_word if not base_word.empty?
    (chain - [base_word]).each { |word|
      if base_word.empty?
        chain_return << longest_chain(chain, word)
      else
        chain_return << longest_chain(chain, word) if base_word[-1, 1].downcase == word[0].downcase
      end
    }
    @chain_longest = chain_return if @chain_longest.size < chain.size
    chain_return
  end
end

#puts %(Test: output chain is #{TestGameWords.new.output_correct? ? 'good' : 'bad'}.)
puts %(Call class GameWords)
puts GameWords.new.longest(%w(bm Mark BoB Jamy))
