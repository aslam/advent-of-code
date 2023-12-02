counts = {
  'red' => 12,
  'green' => 13,
  'blue' => 14
}

File.open('input.txt') do |file|
  valid_games = []
  file.each_line do |record|
    game, reveal = record.split(':')
    subsets = reveal.split(';')
    valid = true
    subsets.each do |subset|
      sets = subset.split(',')
      sets.each do |set|
        count, color = set.split(' ')

        valid = false if count.to_i > counts[color]
      end
    end

    valid_games << game.gsub(/[^0-9]/, '').to_i if valid
  end

  puts "Valid game Ids: #{valid_games}"
  puts "Sum of IDs of valid games: #{valid_games.sum}"
end
