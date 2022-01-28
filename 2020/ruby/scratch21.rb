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

I21s = <<~INPUT
mxmxvkd kfcds sqjhc nhms (contains dairy, fish)
trh fvjkl sbzzf mxmxvkd (contains dairy)
sqjhc fvjkl (contains soy)
sqjhc mxmxvkd sbzzf (contains fish)
INPUT

pp(begin
  data = I21.scan(/^([\w\s]+)\s\(contains (.+)\)$/).
    map{|i,a| [a.split(", "), i.split(" ")]}
  possibilities = data.each_with_object({}) do |(allergens, ingredients), object|
    allergens.each do |a|
      if object[a].nil?
        object[a] = ingredients.dup
      else
        object[a] = object[a] & ingredients
      end
    end
  end

  # Part 1
  impossible = data.map{_1.last}.reduce(:|) - possibilities.values.reduce(:|)
  data.map{_1.last}.reduce(:+).select do |ingredient|
    impossible.include?(ingredient)
  end.length

  # Part 2
  confirmed = {}
  loop do
    break if possibilities.empty?
    possibilities.select { |k, v| v.length == 1 }.each do |key, val|
      confirmed[key] = val.first
      possibilities.delete(key)
      possibilities.each { |k, v| v.delete(val.first) }
    end
    p [confirmed, possibilities]
  end
  confirmed.to_a.sort.map(&:last).join(",")
end)
