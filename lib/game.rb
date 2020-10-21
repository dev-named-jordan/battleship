require './lib/turn'

class Game

  def start
    puts "Welcome to BATTLESHIP"
    puts "Enter p to play. Enter q to quit."
    input = gets.chomp
    if input.downcase == "p"
      turn_setup
      start_round
    elsif input.downcase != "q"
      start
    else
      exit
    end
  end

  def turn_setup
    @turn = Turn.new
    @turn.computer_setup
    human_welcome
    @turn.human_setup
  end

  def human_welcome
    puts "I have laid out my ships on the grid."
    puts "You now need to lay out your two ships."
    puts "The Cruiser is three units long and the Submarine is two units long."
  end

  def start_round
    @turn.round
    end_game
  end

  def end_game
    if @turn.player_points == 5 && @turn.computer_points == 5
      puts "It's tie!"
      start
    elsif @turn.player_points == 5
      puts "You won!"
      start
    elsif @turn.player_points == 5
      puts "I won!"
      start
    else
      start_round
    end
  end
end
