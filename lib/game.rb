require './lib/turn'

class Game
  attr_reader :computer_board, :player_board,  :computer_cruiser, :computer_submarine, :human_cruiser, :human_submarine
  attr_accessor :player_has_fired_at, :computer_has_fired_at,
                :computer_points, :player_points

  def initialize
    @computer_board = Board.new
    @player_board = Board.new
    @player_has_fired_at = []
    @computer_has_fired_at = []
    @computer_points = 0
    @player_points = 0
    @computer_cruiser = Ship.new("Cruiser", 3)
    @computer_submarine = Ship.new("Submarine", 2)
    @human_cruiser = Ship.new("Cruiser", 3)
    @human_submarine = Ship.new("Submarine", 2)
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
    computer_setup(@computer_cruiser, 3)
    computer_setup(@computer_submarine, 2)
    human_setup
    Turn.new.round
  end

  def computer_setup(ship, length)
    coordinates = Array.new
    until @computer_board.valid_placement?(ship, coordinates)
      sample_coordinates = @computer_board.cells.keys.sample(length)
      coordinates = sample_coordinates
    end
    @computer_board.place(ship, coordinates)
  end

  def human_welcome
    puts "I have laid out my ships on the grid."
    puts "You now need to lay out your two ships."
    puts "The Cruiser is three units long and the Submarine is two units long."
  end

  def human_setup
    human_welcome
    cruiser_setup
    submarine_setup
  end

  def cruiser_setup
    puts @player_board.render(true)
    puts "Enter the squares for the Cruiser (3 spaces):"
    cruiser_coordinates = Array(gets.chomp.upcase.split(" "))
    if @player_board.valid_placement?(@human_cruiser, cruiser_coordinates)
      @player_board.place(@human_cruiser, cruiser_coordinates)
      puts @player_board.render(true)
    else
      puts "Don't you know your own ships?"
      cruiser_setup
    end
  end

  def submarine_setup
    puts "Enter the squares for the Submarine (2 spaces):"
    submarine_coordinates = Array(gets.chomp.upcase.split(" "))
    if @player_board.valid_placement?(@human_submarine, submarine_coordinates)
      @player_board.place(@human_submarine, submarine_coordinates)
      puts @player_board.render(true)
    else
      puts "Don't you know your own ships, Capitan?"
      puts @player_board.render(true)
      submarine_setup
    end
  end

  def end_game
    if @player_points == 5 && @computer_points == 5
      puts "It's tie!"
      start
    elsif @player_points == 5
      puts "You won!"
      start
    elsif @player_points == 5
      puts "I won!"
      start
    else
      turn.round
    end
  end
end
