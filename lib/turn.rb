require './lib/board'

class Turn
  attr_reader :computer_board,        :player_board,    :player_has_fired_at,
              :computer_has_fired_at, :computer_points, :player_points

  def initialize
    @computer_board        = Board.new
    @player_board          = Board.new
    @player_has_fired_at   = []
    @computer_has_fired_at = []
    @computer_points       = 0
    @player_points         = 0
    @computer_cruiser      = Ship.new("Cruiser", 3)
    @computer_submarine    = Ship.new("Submarine", 2)
    @human_cruiser         = Ship.new("Cruiser", 3)
    @human_submarine       = Ship.new("Submarine", 2)
  end

  def computer_setup
    computer_ship_setup(@computer_cruiser, 3)
    computer_ship_setup(@computer_submarine, 2)
  end

  def computer_ship_setup(ship, length)
    coordinates = Array.new
    until @computer_board.valid_placement?(ship, coordinates)
      sample_coordinates = @computer_board.cells.keys.sample(length)
      coordinates = sample_coordinates
    end
    @computer_board.place(ship, coordinates)
  end

  def human_setup
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

  def top_of_round_message
    puts "=============COMPUTER BOARD============="
    puts @computer_board.render
    puts "==============PLAYER BOARD=============="
    puts @player_board.render(true)
  end

  def round
    top_of_round_message
    player_shoots
    computer_shoots
    end_of_round_report
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
    computer_report
    player_report
  end

  def computer_report
    computer_shot_status =  @player_board.cells[@computer_shot].render
    if computer_shot_status == "X"
      puts "My shot on #{@computer_shot} sunk your ship."
      @computer_points += 1
    elsif computer_shot_status == "H"
        puts "My shot on #{@computer_shot} was a hit."
        @computer_points += 1
    else
      puts "My shot on #{@computer_shot} was a miss."
    end
  end

  def player_report
    player_shot_status =  @computer_board.cells[@player_shot].render
    if player_shot_status == "X"
      @player_points += 1
      puts "Your shot on #{@player_shot} sunk my ship."
    elsif player_shot_status == "H"
        puts "Your shot on #{@player_shot} was a hit."
        @player_points += 1
    else
      puts "Your shot on #{@player_shot} was a miss."
    end
  end
end
