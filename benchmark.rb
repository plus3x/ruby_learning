require 'benchmark'

n = 1_000_000
a = []
puts "N: #{n}"
Benchmark.bm do |make|
  make.report('  for:') { for i in 1..n do a << i end }
  make.report('times:') { n.times { |e|    a << e } }
  make.report(' upto:') { 1.upto(n) { |e|  a << e } }
  make.report(' each:') { (1..n).each { |e| a << e } }
end