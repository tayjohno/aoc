module Enumerable
  # sum
  def s
    reduce(:+)
  end

  # product
  def p
    reduce(:*)
  end

  # map
  def m(&block)
    map(&block)
  end

  # select
  def se(&block)
    select(&block)
  end

  # reject
  def re(&block)
    reject(&block)
  end
end

class String
  def s
    split
  end

  def sc
    split(",")
  end

  def sn
    split("\n")
  end

  def sc
    chars
  end
end

class Array
  def r
    0..(length - 1)
  end

  def l
    length
  end

  def mi
    map(&:to_i)
  end

  def ms
    map(&:to_s)
  end
end


I17 = <<~INPUT
#...#...
#..#...#
..###..#
.#..##..
####...#
######..
...#..#.
##.#.#.#
INPUT

I17s = <<~INPUT
.#.
..#
###
INPUT


# Enum.m = map
# Enum.se = select
# Enum.re = reject
# Enum.e = each
# Enum.s = sum
# Enum.p = product

# String.sc = split(",")

# Array.r = range of indexes
# Array.l = length
# Array.mi = map(&:to_i)
# Array.ms = map(&:to_s)

require "set"

# def neighbors(x,y,z)
#   (-1..1).flat_map do |dx|
#     (-1..1).flat_map do |dy|
#       (-1..1).map do |dz|
#         [x+dx,y+dy,z+dz]
#       end
#     end
#   end.reject{_1 == [x,y,z]}
# end
#
# def count_neighbors(locations, (x,y,z))
#   neighbors(x,y,z).count{ |l| locations.member?(l) }
# end
# #
# # def active?(locations, (x,y,z))
# #   locations.member?(x,y,z)
# # end
#
# pp(begin
#   data = I17.split("\n").map { |l| l.chars }
#   locations = Set.new
#   data.each_with_index { |row, x| row.each_with_index { |char, y| locations << [x,y,0] if char == "#" }}
#   6.times do
#     new_locations = Set.new
#     # All the existing locations and their neighbors
#     to_check = Set.new(locations)
#     to_check += (locations.flat_map{neighbors(_1,_2,_3)})
#
#     to_check.each do |l|
#       is_active = locations.member?(l)
#       active_neighbors = count_neighbors(locations, l)
#       if is_active
#         if (2..3).cover?(active_neighbors)
#           new_locations << l
#         end
#       else
#         if active_neighbors == 3
#           new_locations << l
#         end
#       end
#     end
#     p new_locations.length
#
#     locations = new_locations
#   end
#   locations.size
# end)


def neighbors(x,y,z,w)
  (-1..1).flat_map do |dx|
    (-1..1).flat_map do |dy|
      (-1..1).flat_map do |dz|
        (-1..1).map do |dw|
          [x+dx,y+dy,z+dz,w+dw]
        end
      end
    end
  end.reject{_1 == [x,y,z,w]}
end

def count_neighbors(locations, (x,y,z,w))
  neighbors(x,y,z,w).count{ |l| locations.member?(l) }
end
#
# def active?(locations, (x,y,z))
#   locations.member?(x,y,z)
# end

pp(begin
  data = I17.split("\n").map { |l| l.chars }
  locations = Set.new
  data.each_with_index { |row, x| row.each_with_index { |char, y| locations << [x,y,0,0] if char == "#" }}
  6.times do
    new_locations = Set.new
    # All the existing locations and their neighbors
    to_check = Set.new(locations)
    to_check += (locations.flat_map{neighbors(_1,_2,_3,_4)})

    to_check.each do |l|
      is_active = locations.member?(l)
      active_neighbors = count_neighbors(locations, l)
      if is_active
        if (2..3).cover?(active_neighbors)
          new_locations << l
        end
      else
        if active_neighbors == 3
          new_locations << l
        end
      end
    end
    p new_locations.length

    locations = new_locations
  end
  locations.size
end)
