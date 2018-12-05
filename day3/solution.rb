data = File.readlines('input.txt')

parser = /\#(?<id>\d+) \@ (?<l>\d+),(?<t>\d+): (?<w>\d+)x(?<h>\d+)/

overlap = Hash.new
cloth = []
1000.times { cloth << Array.new( 1000, "." ) }

data.each do |claim|
  match = parser.match(claim)
  id, l, t, w, h = match["id"], match["l"].to_i, match["t"].to_i, match["w"].to_i, match["h"].to_i
  overlap[id] = true
  (l...l+w).each do |row|
    (t...t+h).each do |column|
      if cloth[row][column] == "."
        cloth[row][column] = match["id"]
      else
        overlap[cloth[row][column]] = false
        overlap[id] = false
        cloth[row][column] = "x" 
      end
    end
  end
end
p cloth.flatten.count("x")
p overlap.key(true)
