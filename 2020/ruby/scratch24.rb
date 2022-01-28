require_relative "./lib/inputs"
require "set"

# module Enumerable
#   # sum
#   def s
#     reduce(:+)
#   end
#
#   # product
#   def p
#     reduce(:*)
#   end
#
#   # map
#   def m(&block)
#     map(&block)
#   end
#
#   # select
#   def se(&block)
#     select(&block)
#   end
#
#   # reject
#   def re(&block)
#     reject(&block)
#   end
# end
#
# class String
#   def s
#     split
#   end
#
#   def sc
#     split(",")
#   end
#
#   def sn
#     split("\n")
#   end
#
#   def sc
#     chars
#   end
# end
#
# class Array
#   def r
#     0..(length - 1)
#   end
#
#   def l
#     length
#   end
#
#   def mi
#     map(&:to_i)
#   end
#
#   def ms
#     map(&:to_s)
#   end
# end


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

I24s = <<~INPUT
sesenwnenenewseeswwswswwnenewsewsw
neeenesenwnwwswnenewnwwsewnenwseswesw
seswneswswsenwwnwse
nwnwneseeswswnenewneswwnewseswneseene
swweswneswnenwsewnwneneseenw
eesenwseswswnenwswnwnwsewwnwsene
sewnenenenesenwsewnenwwwse
wenwwweseeeweswwwnwwe
wsweesenenewnwwnwsenewsenwwsesesenwne
neeswseenwwswnwswswnw
nenwswwsewswnenenewsenwsenwnesesenew
enewnwewneswsewnwswenweswnenwsenwsw
sweneswneswneneenwnewenewwneswswnese
swwesenesewenwneswnwwneseswwne
enesenwswwswneneswsenwnewswseenwsese
wnwnesenesenenwwnenwsewesewsesesew
nenewswnwewswnenesenwnesewesw
eneswnwswnwsenenwnwnwwseeswneewsenese
neswnwewnwnwseenwseesewsenwsweewe
wseweeenwnesenwwwswnew
INPUT


# Coordinate will be based on e-w and NE - SW, so travel NW or SE is akin to diaganol
# (0,0) <- Start
# (1,0) <- North East
# (0,1) <- East
# (-1,0) < South West
# (0,-1) < West
# (1,-1) < North West
# (-1,1) < South East

def move ((x,y), dir)
  case dir
  when "ne"
    [x + 1, y]
  when "sw"
    [x - 1, y]
  when "e"
    [x, y + 1]
  when "w"
    [x, y - 1]
  when "se"
    [x - 1, y + 1]
  when "nw"
    [x + 1, y - 1]
  end
end

def neighbors((x,y))
  [
    [x + 1, y],
    [x - 1, y],
    [x, y + 1],
    [x, y - 1],
    [x - 1, y + 1],
    [x + 1, y - 1]
  ]
end

def starting_tiles
  lines = I24.split().map do |l|
    dirs = l.scan(/(se|ne|nw|sw|e|w)/).flatten
    raise "parser error" unless dirs.join("").length == l.length
    dirs
  end
  lines.map do |line|
    line.reduce([0,0]) { |coord, dir| move(coord, dir) }
  end.tally.to_a.reject {|_, v| v.even?}.map(&:first)
end

# ROUND 1
pp(begin
  starting_tiles.length
end)


# ROUND 2
pp(begin
  black_tiles = starting_tiles
  100.times do |day|
    new_black_tiles = Set.new
    to_check = (black_tiles + black_tiles.map{ |tile| neighbors(tile) }.flatten(1)).uniq
    to_check.each do |tile|
      if black_tiles.include?(tile)
        new_black_tiles << tile if (1..2).cover?(neighbors(tile).count { |coord| black_tiles.include?(coord) })
      else
        new_black_tiles << tile if 2 == (neighbors(tile).count { |coord| black_tiles.include?(coord) })
      end
    end

    black_tiles = new_black_tiles
  end
  black_tiles.length
end)
