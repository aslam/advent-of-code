numbers = []
File.foreach("input.txt") do |line|
  temp = []
  line.chars.each do |c|
    temp << c.to_i if c.ord.between?(48, 57)
  end

  numbers << temp
end

total = 0
numbers.each do |line|
  if line.one?
    value = line.first
    total += ((value * 10) + value)
  else
    total += ((line.first * 10) + line.last)
  end
end

puts "Total: #{total}"
