require 'set'
data = File.readlines('input.txt').map(&:to_i)
puts data.inject(:+)

freq = 0
seen = Set.new
data.cycle { |num|
  freq += num
  (puts freq; break) if not seen.add?(freq)
}
