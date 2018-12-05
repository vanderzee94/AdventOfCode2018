require 'time'

input = File.readlines("input.txt")
  .map! { |l| l.match(/\[([\d\-: ]+)\] ([ \w#]+)/).to_a }
  .sort_by! { |l| Time.parse(l[1]) }

guards = {}
last_guard = nil

input.each { |entry|
  guard = entry[2].match(/#(\d+)/)
  last_guard = guard[1].to_i if guard
  guards[last_guard] ||= {}

  date = DateTime.parse(entry[1])
  guards[last_guard][date.strftime('%m-%d')] ||= '.' * 60

  c = '#' if entry[2] == 'falls asleep'
  c = '.' if entry[2] == 'wakes up'
  next unless c

  guards[last_guard][date.strftime('%m-%d')][date.minute..59] = c * (60 - date.minute)
}

sleepiest = guards.map { |id, s| [id, s.values.join.count('#')] }.max_by { |id, total| total }[0]
mins = (0..59).map { |m| guards[sleepiest].values.map { |s| s[m] }.join.count('#') }
puts sleepiest * mins.each_with_index.max[1]

soln = guards.map do |id, s|
  t = (0..59).map { |m| s.values.map { |s| s[m] }.join.count('#') }
  [id, t.each_with_index.max[1], t.max]
end

soln = soln.max_by { |s| s[2] }
p soln[0] * soln[1]
