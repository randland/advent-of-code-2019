# frozen_string_literal: true

INPUT = File.read(ARGV[0])
DATA = INPUT.split("-").map(&:to_i)

def digits_inc?(pass)
  (0...pass.length-1).all? { |idx| pass[idx].to_i <= pass[idx+1].to_i }
end

def valid_pass?(pass)
  return false unless pass =~ /\d{2,}/

  digits_inc?(pass)
end

def valider_pass?(pass)
  return false unless valid_pass?(pass)

  pass.split("").slice_when { |a, b| a != b }.any? { |group| group.count == 2 }
end

def part_1(min, max)
  (min..max).map(&:to_s).count(&method(:valid_pass?))
end

def part_2(min, max)
  (min..max).map(&:to_s).count(&method(:valider_pass?))
end

puts "Part 1: #{part_1(*DATA)}"
puts "Part 2: #{part_2(*DATA)}"
