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

I22s = <<~INPUT
Player 1:
9
2
6
3
1

Player 2:
5
8
4
7
10
INPUT

class Counter
  def self.next
    @@NEXT ||= 0
    @@NEXT += 1
  end
end

class GameOver < StandardError; end

class Game
  attr_reader :player1, :player2, :round
  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @round = 1
  end

  def winner
    return @player1 if @player2.deck.empty?
    return @player2 if @player1.deck.empty?
    raise "Game is not over!"
  end

  def play
    begin
      loop do
        play_round
      end
    rescue GameOver
      return self
    end
  end

  def play_round
    raise GameOver if @player1.deck.size == 0 || @player2.deck.size == 0

    @round += 1
    card1 = @player1.draw
    card2 = @player2.draw
    if card1 > card2
      @player1.deck << card1 << card2
    elsif card2 > card1
      @player2.deck << card2 << card1
    else
      raise "TIE!?"
    end
    self
  end
end

class Player
  attr_reader :name, :deck
  def initialize(string)
    (name, *deck) = string.split("\n")
    @name = name.tr(':', '')
    @deck = deck.map(&:to_i)
  end

  def draw
    @deck.shift
  end

  def dup
    Player.new("#{name}\n#{deck.join("\n")}")
  end
end

class RecursiveGame
  attr_reader :player1, :player2, :round, :history, :winner, :game

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @game = Counter.next
    @round = 1
    @history = {}
  end

  def play
    # puts "=== Game #{game} ===\n\n"

    loop do
      # puts "-- Round #{round} (Game #{game}) --"
      # puts "#{player1.name}'s deck: #{player1.deck.join(", ")}"
      # puts "#{player2.name}'s deck: #{player2.deck.join(", ")}"
      play_round
    end
  rescue GameOver => ex
    # p ex.message
    @winner
  end

  def play_round
    if player1.deck.empty?
      @winner = player2
      raise GameOver, 'Won the old fashioned way'
    elsif player2.deck.empty?
      @winner = player1
      raise GameOver, 'Won the old fashioned way'
    end

    if history.dig(player1.deck, player2.deck)
      @winner = player1
      raise GameOver, 'History has repeated itself.'
    else
      @history[player1.deck] ||= {}
      @history[player1.deck][player2.deck] = true
    end

    card1 = player1.draw
    card2 = player2.draw

    # puts "Player 1 plays: #{card1}"
    # puts "Player 2 plays: #{card2}"

    if card1 <= player1.deck.size && card2 <= player2.deck.size
      p1, p2 = player1.dup, player2.dup
      p1.deck.slice!(card1..-1)
      p2.deck.slice!(card2..-1)
      # puts "Playing a sub-game to determine the winner...\n\n"
      winner = RecursiveGame.new(p1, p2).play
      if winner.name == 'Player 1'
        player1.deck << card1 << card2
        # puts "Player 1 wins round #{round} of game #{game}!"
      elsif winner.name == 'Player 2'
        player2.deck << card2 << card1
        # puts "Player 2 wins round #{round} of game #{game}!"
      else
        raise "Who won? #{winner.inspect}"
      end
    elsif card1 > card2
      player1.deck << card1 << card2
      # puts "Player 1 wins round #{round} of game #{game}!"
    elsif card2 > card1
      player2.deck << card2 << card1
      # puts "Player 2 wins round #{round} of game #{game}!"
    else
      raise 'TIE!?'
    end
    # puts
    @round += 1
    self
  end
end



# ROUND 1
pp(begin
  game = Game.new(*I22.split("\n\n").map { |str| Player.new(str) })
  # pp game
  game.play.winner.deck.reverse.map.with_index { |card, i| (i+1) * card }.sum
end)

# ROUND 2
pp(begin
  players = I22.split("\n\n").map { |str| Player.new(str) }
  game = RecursiveGame.new(*players)
  # pp game
  game.play.deck.reverse.map.with_index { |card, i| (i+1) * card }.sum
end)
