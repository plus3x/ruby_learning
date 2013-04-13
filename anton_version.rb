def find_longest_chain(collection, base_word = nil)
  if base_word
    longest_chain = [base_word]
    matched_words = find_matched_words(base_word, collection)

    return longest_chain if matched_words.empty?
  else 
    longest_chain = []
    matched_words = collection
  end

  chain = []
  matched_words.each do |word|
    chain = find_longest_chain(collection - [word], word)
  end

  longest_chain += chain
  @acc = longest_chain if @acc.size < longest_chain.size
  longest_chain
end

def find_matched_words(base_word, collection)
  collection.select { |word| word[0] == base_word[-1, 1] }
end

collection = %w{anton valentin nikolay yakov vova alexandr gogi hottab}
@acc = []

puts "Initial collection: #{collection}"
find_longest_chain(collection)
puts "Longest chain: #{@acc}"
