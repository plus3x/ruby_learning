require 'benchmark'

class Anagramm
  def initialize(search_word:, source:)
    @search_word = search_word
    @source = source
  end

  def decremental
    search_word_chars = @search_word.chars
    search_word_size = search_word_chars.size

    @source.select do |word|
      word = word.sub("\n", '')

      next if word.size != search_word_size

      search_word_chars.all? do |char|
        next unless word.chars.include? char

        word.sub!(char, '')
        true
      end
    end
  end

  def grep
    @source.grep(/^(#{@search_word.chars.permutation.map(&:join).join('|')})$/)
  end

  def sorted
    search_word_chars = (@search_word.chars + ["\n"]).sort

    @source.select { |line| search_word_chars == line.chars.sort }
  end
end

class AnagrammTest
  def initialize(search_word:, source:, expected_result:)
    @search_word = search_word
    @source = source
    @expected_result = expected_result
  end

  def process!(method)
    @source.rewind

    result = Anagramm.new(search_word: @search_word, source: @source).send(method)

    puts "Result doesn't match, expected #{@expected_result} but actual #{result}" if result != @expected_result
  end
end

source = File.open('/usr/share/dict/words')
iterations = 10

short_word = 'team'
short_word_expected_result = ["mate\n", "meat\n", "meta\n", "tame\n", "team\n"]
short_word_anagramm_test = AnagrammTest.new(search_word: short_word, source: source, expected_result: short_word_expected_result)

long_word = 'parental'
long_word_expected_result = ["parental\n", "paternal\n", "prenatal\n"]
long_word_anagramm_test = AnagrammTest.new(search_word: long_word, source: source, expected_result: long_word_expected_result)

puts format("Decremental(short word): %10.6f", Benchmark.realtime { iterations.times { short_word_anagramm_test.process!(:decremental) } })
puts format("Grep(short word):        %10.6f", Benchmark.realtime { iterations.times { short_word_anagramm_test.process!(:grep) } })
puts format("Sorted(short word):      %10.6f", Benchmark.realtime { iterations.times { short_word_anagramm_test.process!(:sorted) } })
puts format("Decremental(long word):  %10.6f", Benchmark.realtime { iterations.times { long_word_anagramm_test.process!(:decremental) } })
puts format("Grep(long word):         %10.6f", Benchmark.realtime { iterations.times { long_word_anagramm_test.process!(:grep) } })
puts format("Sorted(long word):       %10.6f", Benchmark.realtime { iterations.times { long_word_anagramm_test.process!(:sorted) } })

#=> Decremental(short word):   1.792951
#=> Grep(short word):          1.659054
#=> Sorted(short word):        7.472412
#=> Decremental(long word):    2.524419
#=> Grep(long word):         195.675385
#=> Sorted(long word):         7.335914
