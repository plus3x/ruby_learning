Thread.new do
  3.times do
    sleep 1
    print '>'
  end
end

Thread.new do
  3.times do
    sleep 1
    print '<'
  end
end

sleep 5
puts