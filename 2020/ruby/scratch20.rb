require_relative "./lib/inputs"

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

I20s = <<~INPUT
Tile 2311:
..##.#..#.
##..#.....
#...##..#.
####.#...#
##.##.###.
##...#.###
.#.#.#..##
..#....#..
###...#.#.
..###..###

Tile 1951:
#.##...##.
#.####...#
.....#..##
#...######
.##.#....#
.###.#####
###.##.##.
.###....#.
..#.#..#.#
#...##.#..

Tile 1171:
####...##.
#..##.#..#
##.#..#.#.
.###.####.
..###.####
.##....##.
.#...####.
#.##.####.
####..#...
.....##...

Tile 1427:
###.##.#..
.#..#.##..
.#.##.#..#
#.#.#.##.#
....#...##
...##..##.
...#.#####
.#.####.#.
..#..###.#
..##.#..#.

Tile 1489:
##.#.#....
..##...#..
.##..##...
..#...#...
#####...#.
#..#.#.#.#
...#.#.#..
##.#...##.
..##.##.##
###.##.#..

Tile 2473:
#....####.
#..#.##...
#.##..#...
######.#.#
.#...#.#.#
.#########
.###.#..#.
########.#
##...##.#.
..###.#.#.

Tile 2971:
..#.#....#
#...###...
#.#.###...
##.##..#..
.#####..##
.#..####.#
#..#.#..#.
..####.###
..#.#.###.
...#.#.#.#

Tile 2729:
...#.#.#.#
####.#....
..#.#.....
....#..#.#
.##..##.#.
.#.####...
####.#.#..
##.####...
##..#.##..
#.##...##.

Tile 3079:
#.#.#####.
.#..######
..#.......
######....
####.#..#.
.#...#.##.
#.#####.##
..#.###...
..#.......
..#.###...
INPUT


class Tile
  attr_accessor :number
  attr_accessor :sides #clockwise
  attr_accessor :contents
  attr_accessor :neighbors
  # 0-3 = rotations; 4-7 = flipped rotations
  attr_reader :configuration

  def initialize(str)
    title,grid = *str.split(":\n")
    @number = title.match(/(\d+)/)[1].to_i
    @contents = grid.split("\n").map{_1.split("")}
    @neighbors = []
    @sides = [
      @contents.first,
      @contents.map(&:last),
      @contents.last.reverse,
      @contents.map(&:first).reverse
    ]
    @configuration = 0
  end

  def dimension
    @contents.first.length
  end

  def reconfigure
    (@configuration += 1) % 8
  end

  def configuration=(n)
    @configuration = n % 8
  end

  def flipped?
    configuration/4 % 2 == 1
  end

  def rotation
    configuration%4
  end

  # Top left to top right
  def top_edge
    transformed.first
  end

  # Top right to bottom right
  def right_edge
    transformed.map(&:last)
  end

  # bottom left to bottom right
  def bottom_edge
    transformed.last
  end

  # top left to bottom left
  def left_edge
    transformed.map(&:first)
  end

  def rotate(matrix)
    l = matrix.length
    output = Array.new(l) {Array.new(l)}
    (0..l-1).each do |x|
      (0..l-1).each do |y|
        output[x][y] = matrix[-(y+1)][x]
      end
    end
    output
  end

  def transformed
    contents.
      then { flipped? ? _1.reverse : _1 }.
      then { |m| rotation.times{ m = rotate(m) }; m }
  end

  def to_strings
    ["#{number} @ #{configuration}".rjust(dimension)] +
    transformed.
      map { |r| r.join("") }
  end

  def to_inner_strings
    transformed[1..-2].map { _1[1..-2].join("") }
  end
end

Placement = Struct.new(:tile, :rotation, :fliped)

class SquareGrid
  attr_accessor :placements
  attr_reader :dimension
  attr_reader :tile_dimension

  def initialize(grid_dimension = 12, tile_dimension = 10)
    @dimension = grid_dimension
    @tile_dimension = tile_dimension
    self.placements = Array.new(dimension) {Array.new(dimension) {nil}}
  end

  def place(location, tiles)

  end

  def locations_to_check
    blank_locations
  end

  def get(x,y)
    nil if x < 0 || x > dimension || y < 0 || y > dimension
    placements.dig(x,y)
  end

  def print_map
    placements.map do |row|
      a, *b = row.map { |tile| tile ? tile.to_inner_strings : blank_tile_strings}
      puts a.zip(*b).map { |section| section.join("") }
    end.flatten
  end

  def to_map
    placements.map do |row|
      a, *b = row.map { |tile| tile ? tile.to_inner_strings : blank_tile_strings}
      a.zip(*b).map { |section| section.join("") }
    end.flatten.map{_1.split("")}
  end

  # def neighbors(location)
  #   (y,x) = location
  #   {
  #     top: if ,
  #     left: ,
  #     right: ,
  #     bottom: ,
  #   }
  # end

  def blank_locations
    [].tap do |locations|
      (0..dimension-1).each do |x|
        (0..dimension-1).each do |y|
          locations << [x,y] if placements.dig(x,y).nil?
        end
      end
    end
  end

  def blank_tile_strings
    [" " * tile_dimension] + ["?" * tile_dimension]* tile_dimension
  end

  def print
    placements.each do |row|
      a, *b = row.map { |tile| tile ? tile.to_strings : blank_tile_strings}
      puts a.zip(*b).map { |section| section.join(" ") }.join("\n")
    end
  end
end

TILES = I20.split("\n\n").map{Tile.new(_1)}

pp(begin
  corners = TILES.select do |tile|
    tile.sides.count do |side|
      TILES.any? do |tile2|
        if tile2 != tile &&
          (tile2.sides.include?(side) ||
          tile2.sides.map(&:reverse).include?(side))
          # puts "Tile #{tile.number} matches #{tile2.number} on #{side}"
          tile.neighbors << tile2.number
          true
        else
          false
        end
      end
    end == 2
  end
  p corners.map(&:number).reduce(:*)

  @tile_bag = TILES.map { [_1.number, _1] }.to_h
  @grid = SquareGrid.new(Math.sqrt(TILES.length).to_i, TILES.first.dimension)
  test_tile = corners[0]
  # p test_tile.number
  # 8.times do
  #   puts test_tile.configuration
  #   puts test_tile.to_strings
  #   test_tile.configuration += 1
  # end
  # Manually placed
  @grid.placements[0][0] = @tile_bag.delete(2833)
  @grid.placements[0][1] = @tile_bag.delete(1907).tap {_1.configuration=7}
  @grid.placements[1][0] = @tile_bag.delete(3761).tap {_1.configuration=5}
  @grid.placements[1][1] = @tile_bag.delete(3847).tap {_1.configuration=7}
  @grid.placements[0][2] = @tile_bag.delete(1669).tap {_1.configuration=1}
  @grid.placements[2][0] = @tile_bag.delete(2161).tap {_1.configuration=5}
  @grid.placements[0][3] = @tile_bag.delete(3023).tap {_1.configuration=1}
  @grid.placements[0][4] = @tile_bag.delete(1381).tap {_1.configuration=4}
  @grid.placements[0][5] = @tile_bag.delete(1699).tap {_1.configuration=5}
  @grid.placements[0][6] = @tile_bag.delete(1889).tap {_1.configuration=4}
  @grid.placements[0][7] = @tile_bag.delete(3541).tap {_1.configuration=3}
  @grid.placements[0][8] = @tile_bag.delete(1901).tap {_1.configuration=3}
  @grid.placements[0][9] = @tile_bag.delete(2351).tap {_1.configuration=5}
  @grid.placements[0][10] = @tile_bag.delete(1019).tap {_1.configuration=3}
  @grid.placements[0][11] = @tile_bag.delete(2239).tap {_1.configuration=7}


  @grid.blank_locations.each do |(x,y)|
    above_tile = @grid.get(x-1,y)
    possible_tiles = @tile_bag.values.select{ |t| t.neighbors.any?{_1 == above_tile.number}}

    found = false
    # pp possible_tiles
    possible_tiles.each do |tile|
      # pp tile
      break if found
      (0..7).each do |configuration|
        break if found
        tile.configuration = configuration
        if tile.top_edge == above_tile.bottom_edge
          found = true
          @grid.placements[x][y] = @tile_bag.delete(tile.number).tap {_1.configuration=configuration}
        end
      end
    end
    # @grid.place([x,y], @tile_bag)
    raise "not found!" unless found
  end


  # pp @tile_bag.values.select{ |t| t.neighbors.any?{_1 == 1019}}

  # @tile_bag.values.each do |tile|
  #   @grid.place(tile)
  # end

  @grid.print

  puts @grid.get(0,0).to_strings
  puts @grid.get(0,0).to_inner_strings

  @grid.print_map
  @map = @grid.to_map


  monster = <<~MONSTER
                    #
  #    ##    ##    ###
   #  #  #  #  #  #
  MONSTER

  @monster_coords = [].tap do |list|
    monster.lines.map(&:chars).each.with_index do |line, x|
      line.each.with_index do |char, y|
        list << [x,y] if char == "#"
      end
    end
  end
  p @monster_coords

  @all_coords = (0..95).map do |x|
    (0..95).map do |y|
      [x,y]
    end
  end

  def count_monsters(map)
    @all_coords.flatten(1).count do |coord|
      is_monster(coord, map)
    end
  end

  def remove_monsters(map)
    @all_coords.flatten(1).count do |coord|
      if is_monster(coord, map)
        remove_monster(coord, map)
      end
    end
  end

  def is_monster((x,y), map)
    @monster_coords.map { |(mx,my)| [ mx + x, my+y] }.all? do |coord|
      map.dig(*coord) == "#"
    end
  end

  def remove_monster((x,y), map)
    @monster_coords.map { |(mx,my)| [ mx + x, my+y] }.all? do |coord|
      map[coord[0]][coord[1]] = "o"
    end
  end

  def rotate(matrix)
    l = matrix.length
    output = Array.new(l) {Array.new(l)}
    (0..l-1).each do |x|
      (0..l-1).each do |y|
        output[x][y] = matrix[-(y+1)][x]
      end
    end
    output
  end

  def flip(matrix)
    matrix.reverse
  end

  # count_monsters(@map)

  @map = rotate(rotate(flip(@map)))

  count_monsters(@map)

  remove_monsters(@map)

  count_monsters(@map)

  @map.flatten.count("#")

  # @grid.print
  # loop do
  #   break if @tile_bag.empty?
  #   @tile_bag.each do |tile|
  #     @tile_bag.delete(tile.number) if @grid.place(tile)
  #   end
  # end

end)
