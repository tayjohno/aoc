require 'set'

# Both parts of the first day of AdventOfCode 2018
class DayOne
  def self.part_one
    new.part_one
  end

  def self.part_two
    new.part_two
  end

  def initialize(file = 'day_1_input.txt')
    @file = file
  end

  def part_one
    File.readlines(@file).map(&:to_i).sum
  end

  def part_two
    sum = 0
    used = Set.new
    File.readlines(@file).map(&:to_i).cycle.each do |line|
      return sum if used.include? sum
      used << sum
      sum += line
    end
  end
end
