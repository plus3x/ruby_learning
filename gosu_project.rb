class Random
  def random_element(collection)
    (rand(1..1000)).times { @element = collection[rand(0..collection.size)] }
    @element
  end
end

films = [
  "Charly and chocolate manufacture",
  "Matrix",
  "Lord of the ring",
  "5 element",
  "Bronx",
  "Django"]
puts "Random film: #{Random.new.random_element(films)}"
