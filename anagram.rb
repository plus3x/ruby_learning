require 'benchmark'

class Anagram
  def initialize(search_word:, source:)
    @search_word = search_word
    @source = source
  end

  def decremental
    search_word_chars = @search_word.chars
    search_word_size = search_word_chars.size

    @source.select do |line|
      word = line.strip

      next if word.size != search_word_size

      search_word_chars.all? { |c| word.sub!(c, '') }
    end
  end

  def grep_and_decremental
    search_word_chars = @search_word.chars

    @source.grep(/^.{#{@search_word.size}}$/).select do |line|
      word = line.strip

      search_word_chars.all? { |c| word.sub!(c, '') }
    end
  end

  def grep
    @source.grep(/^(#{@search_word.chars.permutation.map(&:join).join('|')})$/)
  end

  def sort
    search_word_chars = (@search_word.chars + ["\n"]).sort

    @source.select { |line| search_word_chars == line.chars.sort }
  end

  def grep_and_sort
    search_word_chars = (@search_word.chars + ["\n"]).sort

    @source.grep(/^.{#{@search_word.size}}$/).select { |line| search_word_chars == line.chars.sort }
  end
end

class AnagramTest
  def initialize(search_word:, source:, expected_result:)
    @search_word = search_word
    @source = source
    @expected_result = expected_result
  end

  def process!(method)
    @source.rewind

    result = Anagram.new(search_word: @search_word, source: @source).send(method)

    puts "Result doesn't match, expected #{@expected_result} but actual #{result}" if result != @expected_result
  end
end

source = File.open('/usr/share/dict/words')
iterations = 10

short_word = 'team'

puts "### Short word(#{short_word}) ###"

short_word_expected_result = ["mate\n", "meat\n", "meta\n", "tame\n", "team\n"]
short_word_anagram_test = AnagramTest.new(search_word: short_word, source: source, expected_result: short_word_expected_result)

puts format("Decremental:          %10.6f", Benchmark.realtime { iterations.times { short_word_anagram_test.process!(:decremental) } })
puts format("Grep and decremental: %10.6f", Benchmark.realtime { iterations.times { short_word_anagram_test.process!(:grep_and_decremental) } })
puts format("Grep:                 %10.6f", Benchmark.realtime { iterations.times { short_word_anagram_test.process!(:grep) } })
puts format("Sort:                 %10.6f", Benchmark.realtime { iterations.times { short_word_anagram_test.process!(:sort) } })
puts format("Grep and sort:        %10.6f", Benchmark.realtime { iterations.times { short_word_anagram_test.process!(:grep_and_sort) } })

puts "\n"

long_word = 'parental'

puts "### Long word(#{long_word}) ###"

long_word_expected_result = ["parental\n", "paternal\n", "prenatal\n"]
long_word_anagram_test = AnagramTest.new(search_word: long_word, source: source, expected_result: long_word_expected_result)

puts format("Decremental:          %10.6f", Benchmark.realtime { iterations.times { long_word_anagram_test.process!(:decremental) } })
puts format("Grep and decremental: %10.6f", Benchmark.realtime { iterations.times { long_word_anagram_test.process!(:grep_and_decremental) } })
# puts format("Grep:                 %10.6f", Benchmark.realtime { iterations.times { long_word_anagram_test.process!(:grep) } })
puts format("Sort:                 %10.6f", Benchmark.realtime { iterations.times { long_word_anagram_test.process!(:sort) } })
puts format("Grep and sort:        %10.6f", Benchmark.realtime { iterations.times { long_word_anagram_test.process!(:grep_and_sort) } })

puts "\n"

very_long_word = 'discriminator'

puts "### Very long word(#{very_long_word}) ###"

very_long_word_expected_result = ["discriminator\n", "doctrinairism\n"]
very_long_word_anagram_test = AnagramTest.new(search_word: very_long_word, source: source, expected_result: very_long_word_expected_result)

puts format("Decremental:          %10.6f", Benchmark.realtime { iterations.times { very_long_word_anagram_test.process!(:decremental) } })
puts format("Grep and decremental: %10.6f", Benchmark.realtime { iterations.times { very_long_word_anagram_test.process!(:grep_and_decremental) } })
# puts format("Grep:                 %10.6f", Benchmark.realtime { iterations.times { very_long_word_anagram_test.process!(:grep) } })
puts format("Sort:                 %10.6f", Benchmark.realtime { iterations.times { very_long_word_anagram_test.process!(:sort) } })
puts format("Grep and sort:        %10.6f", Benchmark.realtime { iterations.times { very_long_word_anagram_test.process!(:grep_and_sort) } })

__END__

### Short word(team) ###
Decremental:            0.913660
Grep and decremental:   2.158851
Grep:                   1.646148
Sort:                   7.893614
Grep and sort:          2.273887

### Long word(parental) ###
Decremental:            1.161732
Grep and decremental:   2.703555
Grep:                   > 200
Sort:                   7.926911
Grep and sort:          3.210074

### Very long word(discriminator) ###
Decremental:            1.069861
Grep and decremental:   2.901802
Grep:                   > 999
Sort:                   7.340351
Grep and sort:          3.066173
