# frozen_string_literal: true

INPUT = File.read(ARGV[0])
DATA = INPUT.split("\n")

MOVES = {
  L: ->(coord) { [coord[0] - 1, coord[1]] },
  R: ->(coord) { [coord[0] + 1, coord[1]] },
  D: ->(coord) { [coord[0], coord[1] - 1] },
  U: ->(coord) { [coord[0], coord[1] + 1] }
}.transform_keys(&:to_s).freeze

def move(path, inst)
  inst[1..-1].to_i.times { path.push(MOVES[inst[0]].call(path.last)) }
end

def gen_paths(data)
  data.map do |wire_inst|
    [[0, 0]].tap { |path| wire_inst.split(",").each { |inst| move(path, inst) } }
  end.each(&:shift)
end

def taxi_dist(coord)
  coord.map(&:abs).inject(:+)
end

def wire_dist(coord, paths)
  paths.map { |path| path.index(coord) + 1 }.inject(:+)
end

def part_1(data)
  gen_paths(data).inject(:&).map(&method(:taxi_dist)).min
end

def part_2(data)
  paths = gen_paths(data)
  paths.inject(:&).map { |cross| wire_dist(cross, paths) }.min
end

puts "Part 1: #{part_1(DATA)}"
puts "Part 2: #{part_2(DATA)}"
