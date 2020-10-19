require './lib/board'

class Turn
  attr_accessor :board
  def initialize
    @computer_board = Board.new
    @player_board = Board.new
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
    cruiser_coordinates = Array.new
    until @computer_board.valid_placement?(cruiser, cruiser_coordinates)
      sample_coordinates = @computer_board.cells.keys.sample(3)
      cruiser_coordinates = sample_coordinates
    end
    place(cruiser, cruiser_coordinates)

    submarine_coordinates = Array.new
    until @computer_board.valid_placement?(submarine, submarine_coordinates)
      sample_coordinates = @computer_board.cells.keys.sample(2)
      submarine_coordinates = sample_coordinates
    end
    @computer_board.place(cruiser, cruiser_coordinates)
  end

  def human_setup
    human_cruiser = Ship.new("Cruiser", 3)
    human_submarine = Ship.new("Submarine", 2)
    puts "I have laid out my ships on the grid."
    puts "You now need to lay out your two ships."
    puts "The Cruiser is three units long and the Submarine is two units long."

    #player_loop
    player_board.render(true)
    puts "Enter the squares for the Cruiser (3 spaces):"
    cruiser_input = gets.chomp
    if @player_board.valid_placement?(cruiser, cruiser_input)
      place_ship(cruiser, cruiser_input)
      @player_board.render(true)
    else
      puts "Don't you know your own ships?"
      puts "Enter valid coordinates for the Cruiser (3 spaces):"
      player_board.render(true)
      #must go back to top of player_loop
    end

    puts "Enter the squares for the submarine"



  end


end

#start
