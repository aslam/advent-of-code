class Solver
  attr_reader :data

  def initialize(file_path)
    @data = parse(file_path)
  end

  def part_one
    total = 0
    data.each do |card, numbers|
      c = (numbers[0] & numbers[1])

      total += 2**(c.size - 1) if c.any?
    end

    total
  end

  def part_two
    total = 0
    counts = Hash.new(0)
    data.each do |card, numbers|
      counts[card] += 1

      while (counts[card] > 0)
        c = (numbers[0] & numbers[1])
        c.size.times do |n|
          counts[card + n + 1] += 1
        end

        total += 1
        counts[card] -= 1
      end
    end

    total
  end

  def solve
    puts "Part One: #{part_one}"
    puts "Part Two: #{part_two}"
  end

  private

  def parse(file_path)
    File.read("input.txt").split("\n")
      .map { |line| line.split(":") }
      .collect do |card, numbers|
        [
          card.gsub(/[^0-9]/, '').to_i,
          numbers.split('|').collect { |list| list.split(" ").map(&:to_i) }
        ]
      end.to_h
  end
end

solver = Solver.new("input.txt")
solver.solve
