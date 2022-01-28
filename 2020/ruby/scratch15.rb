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
#
# @history = []
# def last_spoken
#   # p @history
#   i = @history[0..-2].reverse.find_index{ |i| i == @history.last }
#   # p i
#   if i
#     i + 1
#   else
#     0
#   end
# end
#
# MAX = 2020
#
# # I15 = "0,3,6"
# # MAX = 10
#
# pp(begin
#   @history = I15.split(",").map(&:to_i)
#   loop do
#     break @history.last if @history.length == MAX
#     @history << last_spoken
#   end
# end)


# { number: last_spoken }
@history = {}
@last = nil
@previous_history = {}
@count = 0

def last_spoken(num, count)
  count - (@history[num] || count)
end

# MAX = 2020
# MAX = 2020
# TODO: This is the answer to part 2
# MAX = 3_000_000
MAX = 30_000_000

# I15 = "0,3,6"
# MAX = 10

pp(begin
  history = I15.split(",").map(&:to_i)
  @history = history[0..-1].map.with_index { |item, index| [item, index] }.to_h
  # @last = history[-1] # 6
  @last = history.last
  @next = 0
  # @history = @previous_history.dup
  # @history[history.last] = history.length - 1
  (history.length..MAX-1).each do |count|
    @history[@last] = count - 1

    @last, @next = @next, last_spoken(@next, count)
  end
  @last

  # {
  #   0: 0, # 0 was last seen at t = 0
  #   3: 1, # 3 was last seen at t = 1
  #   6: 2, # 2 was last seen at t = 2
  # }
  # @last = [6,0]

  # after one iteration

  # @history = {
  #   3: 1, # 3 was last seen at t = 1
  #   6: 2, # 2 was last seen at t = 2
  #   0: 3, # 0 was last seen at t = 3
  # }
  # @last = [0,3] # [number spoken, time to previous]



  # after two iteration

  # {
  #   3: 1, # 3 was last seen at t = 1
  #   6: 2, # 2 was last seen at t = 2
  #   0: 3, # 0 was last seen at t = 3
  # }

  # loop do
    # @history is from previous round
    # @last (int) tells what needs to be added to the history
    # @next (int) tells what should be computed for next
end)
