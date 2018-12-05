require 'set'
data = File.readlines('input.txt')

doubles, triples = 0, 0
word_webs = Hash.new
data.each{|id|
  id.chop()
  counts = Hash.new(0)
  web = Set.new
  id.chars.each_with_index do |char,index| 
    counts[char]+=1
    id[index] = "*"
    web << id
    id[index] = char
  end
  counts.values.to_set.each do |val|
    doubles += 1 if val==2
    triples += 1 if val==3
  end
  word_webs[id]=web
}

p doubles * triples
word_webs.keys.each do |a|
  word_webs.keys.each do |b|
    p (word_webs[a] & word_webs[b]).to_a[0].gsub('*','').chop if word_webs[a].intersect?(word_webs[b]) and not a == b
  end
end
