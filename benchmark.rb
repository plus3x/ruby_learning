require "benchmark"

n = 50000
Benchmark.bm do |make|
  make.report("  for:") { for i in 1..n { a = "1" } }
  make.report("times:") { n.times     { a = "1" } }
  make.report(" upto:") { 1.upto(n)   { a = "1" } }
  make.report(" each:") { (1..n).each { a = "1" } }
end