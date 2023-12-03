symbols = [ "*", "/", "@", "&", "$", "=", "#", "-", "+", "%"]

input = File.read('input.txt').split("\n")
symbol_map = {}
input.each.with_index do |row, index|
  locations = []
  symbols.each do |symbol|
    pos = -1
    while (pos = row.index(symbol, pos + 1))
      locations << pos
    end
  end
  symbol_map[index] = locations
end

numbers_map = Hash.new { |h, k| h[k] = [] }
input.each.with_index do |row, index|
  numbers = []
  locations = []
  row.chars.each.with_index do |c, i|
    if c.ord.between?(48, 57)
      numbers << c
      locations << i
    elsif numbers.any?
      numbers_map[index] << [numbers.join.to_i, locations]
      numbers = []
      locations = []
    end
  end

  if numbers.any?
    numbers_map[index] << [numbers.join.to_i, locations]
    numbers = []
    locations = []
  end
end

total = 0
numbers_map.each do |row, locations|
  locations.each do |number, positions|
    range = (positions[0] - 1..positions[-1] + 1).to_a
    # First check whether the same row in symbols table has any symbols before or after the location
    if symbol_map[row].include?(range[0]) || symbol_map[row].include?(range[-1])
      total += number
    end

    # Check whether the previous row in symbols table has any symbols before or after the location
    if symbol_map.key?(row - 1) && (symbol_map[row - 1] & range).any?
      total += number
    end

    # Check whether the next row in symbols table has any symbols before or after the location
    if symbol_map.key?(row + 1) && (symbol_map[row + 1] & range).any?
      total += number
    end
  end
end

puts "Total: #{total}"
