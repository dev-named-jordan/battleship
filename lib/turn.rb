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
      setup_game
    elsif input.downcase != "q"
      start
    else
      exit
    end
  end

  def setup_game
    computer_setup
    human_setup
  end

#class Game

  def computer_setup
    @computer_cruiser = Ship.new("Cruiser", 3)
    @computer_submarine = Ship.new("Submarine", 2)
    cruiser_coordinates = Array.new
    until @computer_board.valid_placement?(@computer_cruiser, cruiser_coordinates)
      sample_coordinates = @computer_board.cells.keys.sample(3)
      cruiser_coordinates = sample_coordinates
    end
    place(cruiser, cruiser_coordinates)

    submarine_coordinates = Array.new
    until @computer_board.valid_placement?(@computer_submarine, submarine_coordinates)
      sample_coordinates = @computer_board.cells.keys.sample(2)
      submarine_coordinates = sample_coordinates
    end
    @computer_board.place(@computer_submarine, submarine_coordinates)
  end

  def human_setup
    @human_cruiser = Ship.new("Cruiser", 3)
    @human_submarine = Ship.new("Submarine", 2)
    puts "I have laid out my ships on the grid."
    puts "You now need to lay out your two ships."
    puts "The Cruiser is three units long and the Submarine is two units long."
    cruiser_setup
    submarine_setup
  end

  def cruiser_setup
    @player_board.render(true)
    puts "Enter the squares for the Cruiser (3 spaces):"
    cruiser_input = gets.chomp
    if @player_board.valid_placement?(cruiser, cruiser_input)
      place_ship(@human_cruiser, cruiser_input)
      @player_board.render(true)
    else
      puts "Don't you know your own ships?"
      cruiser_setup
    end
  end

  def submarine_setup
    puts "Enter the squares for the Submarine (2 spaces):"
    submarine_input = gets.chomp
    if @player_board.valid_placement?(@human_submarine, submarine_input)
      place_ship(@human_submarine, submarine_input)
      @player_board.render(true)
    else
      puts "Don't you know your own ships, Capitan?"
      @player_board.render(true)
      submarine_setup
    end
  end
end

#start
