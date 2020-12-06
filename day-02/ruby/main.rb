# frozen_string_literal: true

INPUT = File.read(ARGV[0])
DATA = INPUT.split(",").map(&:to_i)

def fix_data(data, noun, verb)
  data.clone.tap do |fixed_data|
    fixed_data[1], fixed_data[2] = noun, verb
  end
end

def intcode_runner(data, idx)
  case(data[idx])
  when 1
    data[data[idx + 3]] = data[data[idx + 1]] + data[data[idx + 2]]
    intcode_runner(data, idx + 4)
  when 2
    data[data[idx + 3]] = data[data[idx + 1]] * data[data[idx + 2]]
    intcode_runner(data, idx + 4)
  when 99
    data[0]
  end
end

def part_1(data)
  intcode_runner(fix_data(data, 12, 2), 0)
end

def part_2(data)
  (0..99).each do |noun|
    (0..99).each do |verb|
      intcode_runner(fix_data(data, noun, verb), 0).tap do |result|
        return noun * 100 + verb if result == 19690720
      end
    end
  end
end

puts "Part 1: #{part_1(DATA)}"
puts "Part 2: #{part_2(DATA)}"
