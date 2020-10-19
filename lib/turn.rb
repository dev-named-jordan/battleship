require './lib/board'

class Turn
  attr_accessor :board
  def initialize
    @board = Board.new
  end

  def start
    puts "Welcome to BATTLESHIP"
    puts "Enter p to play. Enter q to quit."
    input = gets.chomp
    if input.downcase == "p"
      # require "pry"; binding.pry
      setup_game
    elsif input.downcase != "q"
      start
    else
      exit
    end
  end

#class Game

  def computer_setup
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    testing_coordinates = Array.new
    until @board.valid_placement?(cruiser, testing_coordinates)
      sample_coordinates = @board.cells.keys.sample(3)
      testing_coordinates = sample_coordinates
    end
    testing_coordinates
  end

  def human_setup

  end


end

#start
