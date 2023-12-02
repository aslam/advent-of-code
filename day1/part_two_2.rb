numbers = {
  'zero' => 'zero0zero',
  'one' => 'one1one',
  'two' => 'two2two',
  'three' => 'three3three',
  'four' => 'four4four',
  'five' => 'five5five',
  'six' => 'six6six',
  'seven' => 'seven7seven',
  'eight' => 'eight8eight',
  'nine' => 'nine9nine'
}

File.open('input.txt') do |file|
  total = 0
  file.each_line.with_index do |line, index|
    # replace any number words with the number
    numbers.each do |word, number|
      line.gsub!(word, number)
    end
    # strip out all non-numbers
    line.gsub!(/[^0-9]/, '')
    # add (first + last) to total
    puts "#{index + 1} => [#{line[0]}, #{line[-1]}]"
    # puts "[#{line[0]}, #{line[-1]}]"
    total += (line[0] + line[-1]).to_i
  end
  puts "Total: #{total}"
end
