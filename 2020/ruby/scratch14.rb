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

# I14 = <<~INPUT
# mask = XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X
# mem[8] = 11
# mem[7] = 101
# mem[8] = 0
# INPUT
# I14 = <<~INPUT
# mask = 000000000000000000000000000000X1001X
# mem[42] = 100
# mask = 00000000000000000000000000000000X0XX
# mem[26] = 1
# INPUT

Flip = Struct.new(:value, :bit) do
  def mask(other)
    chars = other.to_s(2).chars
    chars = ["0"]*(36 - chars.length) + chars
    chars[-(bit+1)] = value
    chars.join("")
    chars.join("").to_i(2)
  end
end

def addresses(mask, address)
  loose_bits = mask.split("").map.with_index do |x,i|
    [x == "X", 35 - i]
  end.select{ |t,i| t}.map{_2}
  bit_values = [0, 1].repeated_permutation(loose_bits.length).to_a
  flip_sets = bit_values.map{|c| c.map.with_index{ |v,i| Flip.new(v, loose_bits[i]) } }
  base_address = (address | mask.tr("01X","010").to_i(2))
  flip_sets.map do |bit_flips|
    address = base_address
    bit_flips.each do |flip|
      address = flip.mask(address)
    end
    address
  end
end

pp(begin
  code = I14.lines.map do |line|
    a = line.match(/mask = ([01X]+)/)
    next ["mask", a[1]] if a
    b = line.match(/mem\[(\d+)\] = (\d+)/)
    ["mem", b[1], b[2]]
  end
  # mem = {}
  # mask = nil
  # code.each.with_index do |line, i|
  #   case line[0]
  #   when "mask"
  #     mask = line[1]
  #   when "mem"
  #     p(line)
  #     p(line[2].to_i.to_s(2), mask.tr("01X","100"), mask.tr("01X","010"))
  #     mem[line[1].to_i] =
  #       (line[2].to_i & mask.tr("01X","011").to_i(2)).tap{p _1.to_s(2)} | mask.tr("01X","010").to_i(2)
  #   else
  #     raise "WTF?"
  #   end
  #   pp [i, mask, mem]
  # end
  # p mem.values.sum


  # PART TWO
  mem = {}
  mask = nil
  code.each.with_index do |line, i|
    case line[0]
    when "mask"
      mask = line[1]
    when "mem"
      val = line[2].to_i
      addresses = addresses(mask, line[1].to_i).each do |a|
        mem[a] = val
      end
    else
      raise "WTF?"
    end
    pp [mem.keys.length]
  end
  p mem.values.sum


  # Something to try...
  # total = 0
  # mask = nil
  # code.each.with_index do |line, i|
  #   case line[0]
  #   when "mask"
  #     mask = 2 ** line[1].count("X")
  #   when "mem"
  #     total += mask * line[2].to_i
  #   else
  #     raise "WTF?"
  #   end
  #   pp [i, mask, total]
  # end
  # p total
end)
