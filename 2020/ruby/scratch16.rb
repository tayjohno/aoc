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

require "set"

pp(begin
  my_ticket = I16.lines[22]
  tickets = I16.split("nearby tickets:")[1].lines.map{_1.gsub("\n","")}[1..-1]
  rules = I16.lines.first(20).map{_1.split(": ")[1].gsub("\n","").split(" or ")}.flatten.map{_1.split("-").map(&:to_i)}
  valid_values = Set.new()
  rules.each do |r|
    (r[0]..r[1]).each do |i|
      valid_values << i
    end
  end
  invalid = []
  tickets.map{_1.split(",").map(&:to_i)}.flatten.each do |i|
    invalid << i unless valid_values.include?(i)
  end
  invalid.sum
  valid_tickets = tickets.map{_1.split(",").map(&:to_i)}.select do |ticket|
    ticket.all?{ |value| valid_values.include?(value) }
  end
  [tickets.length, valid_tickets.length]
  rules = I16.lines.first(20).map{_1.split(": ")}.map { |(name, rule)| [name, rule.gsub("\n","").split(" or ").map{|l| l.split("-").then{|min, max| (min.to_i)..(max.to_i)}}]}
  # rules = [position, name, valid_values]
  rules.map! { |(*args)| [nil, *args] }
  loop do
    pp(rules)
    break if rules.all? { |r| r[0] }
    (0..valid_tickets.first.length - 1).each do |column|
      # check if column value has been determined
      next if rules.any? { |r| r[0] == column }

      matching = rules.reject{|r| r[0] != nil }.select do |r|
        valid_tickets.map { |t| t[column] }.all? do |value|
          # p "checking #{value} against #{r[2][0]} and #{r[2][1]}"
          r[2][0].cover?(value) || r[2][1].cover?(value)
        end
      end
      # puts "column #{column} could be #{matching.map{_1[1]}}"
      if matching.length == 1
        next matching[0][0] = column
      elsif matching.length == 0
        raise "invalid...?"
      end
    end

    # pp(rules)
    # break "loop averted"
    # [[4, "departure location", [36..363, 377..962]],
    #  [11, "departure station", [29..221, 234..953]],
    #  [9, "departure platform", [39..585, 595..954]],
    #  [0, "departure track", [31..727, 753..952]],
    #  [3, "departure date", [33..862, 883..964]],
    #  [7, "departure time", [35..716, 722..971]],
    #  89 * 113 * 167 * 109 * 131 * 157
    #
    #  1 179
    #  2 173
    #  5 127
    #  6 163
    #  8 137
    #  10 151
    #  12 97
    #  13 149
    #  14 107
    #  15 83
    #  16 79
    #  17 139
    #  18 59
    #  19 53

  end
end)
