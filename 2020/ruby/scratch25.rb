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

I25s = <<~INPUT
5764801
17807724
INPUT

# ROUND 1
pp(begin
  public_keys = I25.split().map(&:to_i)
  value = 1
  public_keys
  loop_lengths = []
  (0..).each do |i|
    if public_keys.include?(value)
      public_keys.delete(value)
      break "loop_length: #{i}, public_key: #{public_keys.first}"
    end
    break if public_keys.empty?

    value = (value * 7) % 20201227
    # p "#{i}: #{value}"
  end
  value = 1
  12413864.times do
    value = (value * 12092626) % 20201227
  end
  value
end)


# ROUND 2
pp(begin
end)
