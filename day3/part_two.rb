input = File.read('input.txt').split("\n")
symbol_map = {}
input.each.with_index do |row, index|
  locations = []
  pos = -1
  while (pos = row.index('*', pos + 1))
    locations << pos
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

  numbers_map[index] << [numbers.join.to_i, locations] if numbers.any?
end

total = 0
participants = Hash.new { |h, k| h[k] = [] }
symbol_map.each do |row, locations|
  locations.each.with_index do |loc, i|
    same_row_adjacent = numbers_map[row].select do |n, locs|
      locs.include?(loc - 1) || locs.include?(loc + 1)
    end

    if same_row_adjacent.size == 2
      total += (same_row_adjacent.first[0] * same_row_adjacent.last[0])
      next
    end

    above_row_adjacent = []
    if numbers_map.key?(row - 1)
      above_row_adjacent = numbers_map[row - 1].select do |n, locs|
        (locs[0] - 1..locs[-1] + 1).to_a.include?(loc)
      end

      if above_row_adjacent.size == 2
        total += (above_row_adjacent.first[0] * above_row_adjacent.last[0])
        next
      end
    end

    below_row_adjacent = []
    if numbers_map.key?(row + 1)
      below_row_adjacent = numbers_map[row + 1].select do |n, locs|
        (locs[0] - 1..locs[-1] + 1).to_a.include?(loc)
      end

      if below_row_adjacent.size == 2
        total += (below_row_adjacent.first[0] * below_row_adjacent.last[0])
        next
      end
    end

    considerations = []
    [above_row_adjacent, same_row_adjacent, below_row_adjacent].each do |selections|
      considerations << selections.flatten if selections.any?
    end
    if considerations.size >= 2
      considered = considerations.first(2)
      total += (considered.first[0] * considered.last[0])
    end
  end
end

puts "Total: #{total}"
