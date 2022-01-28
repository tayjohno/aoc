require_relative "./lib/inputs"

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

I23s = <<~INPUT
389125467
INPUT


def print_move(move)
  puts "-- move #{move+1} --"
end

def print_cups(i, cups)
  print 'cups: '
  cups.each.with_index do |cup, j|
    if j == i
      print "(#{cup}) "
    else
      print "#{cup} "
    end
  end
  print "\n"
end

def print_pick_up(pick_up)
  puts "pick up: #{pick_up.join(', ')}"
end

def print_destination(destination)
  puts "destination: #{destination}"
end

def next_destination(cups, val)
  until cups.include?(val)
    return cups.max if val < 1

    val -= 1
  end
  val
end

# ROUND 1
# pp(begin
#   cups = I23.gsub(/\s/, '').split('').map(&:to_i)
#   100.times do |move|
#     i = move % cups.length
#     current_cup = cups[i]
#     print_move(move)
#     print_cups(i, cups)
#
#     pick_up = cups.slice!(i + 1, 3)
#     head_size = 3 - pick_up.length
#     pick_up += cups.slice!(0, head_size) if head_size.positive?
#     print_pick_up(pick_up)
#
#     destination = next_destination(cups, current_cup - 1)
#     print_destination(destination)
#     destination = cups.index(destination) + 1
#     pick_up.reverse.each do |cup|
#       cups.insert(destination, cup)
#     end
#     until cups[i] == current_cup
#       cups.rotate!
#     end
#     puts
#   end
#
#   puts "-- final --"
#   print_cups(10 % cups.length, cups)
#   # puts "NOT \"34869527\""
#   cups.join("").split("1").reverse.join("")
# end)

def print_linked_cups(current_cup, linked_cups)
  print "cups: "
  print current_cup == 1 ? "(1)" : "1"
  cup = 1
  loop do
    cup = linked_cups[cup]
    break if cup == 1
    print (cup == current_cup ?  " (#{cup})" : " #{cup}")
  end
  puts
end

# def print_linked_pickup(cup, l)
#   print "pick up: "
#   puts "#{l[cup]}, #{l[l[cup]]}, #{l[l[l[cup]]]}"
# end

def print_solution(linked_cups)
  pp linked_cups[1] * linked_cups[linked_cups[1]]
end

def make_linked_cups(cups)
  linked_cups = Array.new(cups.length + 1)
  linked_cups[0] = 0
  # 0 will always be 0 in linked_cups, so we can use labels for lookups
  cups.each.with_index do |c, i|
    linked_cups[c] =
      if i == cups.length - 1
        cups[0]
      else
        cups[i + 1]
      end
  end
  linked_cups
end

# ROUND 2
pp(begin
  START = Time.now
  cups = I23.gsub(/\s/, '').split('').map(&:to_i)# + (10..1_000_000).to_a
  cups += (10..1_000_000).to_a
  current_cup = cups[0]
  linked_cups = make_linked_cups(cups)

  10_000_000.times do |move|
    # print_move(move)
    # print_solution(linked_cups)
    # print_linked_cups(current_cup, linked_cups)
    # print_linked_pickup(current_cup, linked_cups)

    pick_up = [linked_cups[current_cup], linked_cups[linked_cups[current_cup]], linked_cups[linked_cups[linked_cups[current_cup]]]]
    # print_pick_up(pick_up)


    tmp = linked_cups[current_cup]
    linked_cups[current_cup] = linked_cups[linked_cups[linked_cups[linked_cups[current_cup]]]]
    destination = current_cup - 1
    while pick_up.include?(destination) || destination <= 0
      destination -= 1
      destination = cups.length if destination <= 0
    end
    # print_destination(destination)
    linked_cups[linked_cups[linked_cups[tmp]]] = linked_cups[destination]
    linked_cups[destination] = tmp
    current_cup = linked_cups[current_cup]

    # puts
  end

  # 6AM UTC

  # puts "-- final --"
  # print_cups(10 % cups.length, cups)
  # puts "NOT \"34869527\""
  # print_linked_cups(current_cup, linked_cups)
  print_solution(linked_cups)
  # cups.join("").split("1").reverse.join("")
end)
