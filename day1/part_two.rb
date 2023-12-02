numbers = []
numbers_in_words = ['zero', 'one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine']

def scan_for_locations(str, numbers_in_words)
  locations = []
  numbers_in_words.each.with_index do |number, index|
    pos = -1
    while(pos = str.index(number, pos + 1))
      locations << [index, pos]
    end
  end

  locations
end

File.foreach("input.txt") do |line|
  temp = []
  word = []
  line.chars.each do |c|
    if c.ord.between?(48, 57)
      if numbers_in_words.any? { |num| (word.join).include?(num) }
        locations = scan_for_locations(word.join, numbers_in_words)
        locations.sort_by!(&:last).each { |i, _| temp << i }
      end

      temp << c.to_i
      word = []
    else
      word << c
    end
  end

  if numbers_in_words.any? { |num| (word.join).include?(num) }
    locations = scan_for_locations(word.join, numbers_in_words)
    locations.sort_by!(&:last).each { |i, _| temp << i }
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
