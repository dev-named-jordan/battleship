require './lib/board'

class Turn
  attr_accessor :board
  def initialize
    @computer_board = Board.new
    @player_board = Board.new
    @player_has_fired_at = []
    @computer_has_fired_at = []
    @computer_points = 0
    @player_points = 0
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
    round
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
    @computer_board.place(@computer_cruiser, cruiser_coordinates)

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

  def round
    puts "=============COMPUTER BOARD============="
    puts @computer_board.render
    puts "==============PLAYER BOARD=============="
    puts @player_board.render(true)
    player_shoots
    computer_shoots
    end_of_round_report
    end_game
  end

  def player_shoots
    puts "Enter the coordinate for your shot:"
    @player_shot = gets.upcase.chomp
    if (@computer_board.valid_coordinate?(@player_shot)) && (@player_has_fired_at.include?(@player_shot) == false)
      @computer_board.cells[@player_shot].fire_upon
      @player_has_fired_at << @player_shot
    else
      puts "That's not a good shot. Choose again."
      player_shoots
    end
  end

  def computer_shoots
    @computer_shot = @player_board.cells.keys.sample
    if @computer_has_fired_at.include?(@computer_shot) == false
      @player_board.cells[@computer_shot].fire_upon
      @computer_has_fired_at << @computer_shot
    else
      computer_shoots
    end
  end

  def end_of_round_report
    computer_report =  @player_board.cells[@computer_shot].render
    if computer_report == "X"
      puts "My shot on #{@computer_shot} sunk your ship."
      @computer_points += 1
    elsif computer_report == "H"
        puts "My shot on #{@computer_shot} was a hit."
        @computer_points += 1
    else
      puts "My shot on #{@computer_shot} was a miss."
    end
    player_report =  @computer_board.cells[@player_shot].render
    if player_report == "X"
      @player_points += 1
      puts "Your shot on #{@player_shot} sunk my ship."
    elsif player_report == "H"
        puts "Your shot on #{@player_shot} was a hit."
        @player_points += 1
    else
      puts "Your shot on #{@player_shot} was a miss."
    end
  end

  def end_game
    if @player_points == 5 && @computer_points == 5
      puts "It's tie!"
    elsif @player_points == 5
      puts "You won!"
    elsif @player_points == 5
      puts "I won!"
    else
      round
    end
  end
end
