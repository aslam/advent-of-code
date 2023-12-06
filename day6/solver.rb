class Solver
  def initialize(file_path)
    @data = []
    parse(file_path)
  end

  def solve
    part_one
    part_two
  end

  def part_one
    input = @data.transpose.map { |a, b| [a.to_i, b.to_i] }
    result = input.map do |time, distance|
      calculate(time, distance)
    end.inject(&:*)

    puts "Part One: #{result}"
  end

  def part_two
    time = @data.first.join.to_i
    distance = @data.last.join.to_i

    puts "Part Two: #{calculate(time, distance)}"
  end

  private

  def calculate(time, distance)
    count = 0
    time.times do |i|
      count += 1 if i * (time - i) > distance
    end

    count
  end

  def parse(file_path)
    @data = File.read(file_path)
      .split("\n")
      .map { |l| l.split(':') }
      .collect(&:last)
      .map { |r| r.split(" ") }

  end
end

solver = Solver.new('input.txt')
solver.solve
