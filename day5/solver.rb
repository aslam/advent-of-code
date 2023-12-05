class Solver
  attr_reader :seeds, :maps

  def initialize(file_path)
    @seeds = []
    @maps = {}
    parse(file_path)
  end

  def solve
    puts "Part One: #{part_one}"
    puts "Part Two: #{part_two}"
  end

  def part_one
    @locations = @seeds.map do |seed|
      determine_location(seed)
    end

    @locations.min
  end

  def part_two
    @locations.each_slice(2).map(&:first).min
  end

  private

  def get_number_for(key, input)
    number = nil
    row = @maps[key].find do |dest_start, src_start, length|
      (src_start...(src_start + length)).include?(input)
    end

    row ? input - row[1] + row[0] : input
  end

  def determine_location(seed)
    input = seed
    [
      'seed-to-soil',
      'soil-to-fertilizer',
      'fertilizer-to-water',
      'water-to-light',
      'light-to-temperature',
      'temperature-to-humidity',
      'humidity-to-location'
    ].each do |map|
      input = get_number_for(map, input)
    end

    input
  end

  def parse(file_path)
    data = {}
    File.open(file_path) do |file|
      file.each_line do |line|
        next if line.strip.empty?

        if line.include?(":")
          key, values = line.split(":")

          key = key.split(' ').first
          if values.empty?
            data[key] = []
          else
            data[key] = values.strip.split(" ").map(&:to_i)
          end
        else
          data[data.keys.last] << line.strip.split(" ").map(&:to_i)
        end
      end
    end

    @seeds = data.delete('seeds')
    @maps = data
  end
end

solver = Solver.new('input.txt')
solver.solve
