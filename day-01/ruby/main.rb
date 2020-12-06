# frozen_string_literal: true

INPUT = File.read(ARGV[0])
DATA = INPUT.split("\n")

def basic_fuel_needed(mass)
  mass.to_i / 3 - 2
end

def compound_fuel_needed(mass)
  fuel = basic_fuel_needed(mass)
  return 0 if fuel < 0

  fuel + compound_fuel_needed(fuel)
end

def part_1(data)
  data.map(&method(:basic_fuel_needed)).inject(:+)
end

def part_2(data)
  data.map(&method(:compound_fuel_needed)).inject(:+)
end

puts "Part 1: #{part_1(DATA)}"
puts "Part 2: #{part_2(DATA)}"
