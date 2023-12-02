File.open('input.txt') do |file|
  min_cubes = {}
  file.each_line do |record|
    game, reveal = record.split(':')
    sets = reveal.split(';')
    counts = { 'red' => 0, 'green' => 0, 'blue' => 0 }
    sets.each do |subset|
      subsets = subset.split(',')
      subsets.each do |color_count|
        count, color = color_count.split(' ')

        if count.to_i > counts[color]
          counts[color] = count.to_i
        end
      end
    end

    game_id = game.gsub(/[^0-9]/, '').to_i
    min_cubes[game_id] = counts.values.reduce(:*)
  end

  puts "Min cubes per game: #{min_cubes}"
  puts "Sum of min cubes per game: #{min_cubes.values.sum}"
end
