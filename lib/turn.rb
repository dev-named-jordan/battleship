require './lib/board'
require './lib/game'

class Turn
# Error starting in line 8, game. is not referring to game @game = Game.new
  def top_of_round_message
    puts "=============COMPUTER BOARD============="
    puts game.computer_board.render
    puts "==============PLAYER BOARD=============="
    puts game.player_board.render(true)
  end

  def round
    top_of_round_message
    player_shoots
    computer_shoots
    end_of_round_report
    game.end_game
  end

  def player_shoots
    puts "Enter the coordinate for your shot:"
    @player_shot = gets.upcase.chomp
    if (@computer_board.valid_coordinate?(@player_shot)) && (@player_has_fired_at.include?(@player_shot) == false)
      @computer_board.cells[@player_shot].fire_upon
      game.player_has_fired_at << @player_shot
    else
      puts "That's not a good shot. Choose again."
      player_shoots
    end
  end

  def computer_shoots
    @computer_shot = @player_board.cells.keys.sample
    if game.computer_has_fired_at.include?(@computer_shot) == false
      @player_board.cells[@computer_shot].fire_upon
      game.computer_has_fired_at << @computer_shot
    else
      computer_shoots
    end
  end

  def end_of_round_report
    computer_report
    player_report
  end

  def computer_report
    computer_shot_status =  game.player_board.cells[@computer_shot].render
    if computer_shot_status == "X"
      puts "My shot on #{@computer_shot} sunk your ship."
      game.computer_points += 1
    elsif computer_shot_status == "H"
        puts "My shot on #{@computer_shot} was a hit."
        game.computer_points += 1
    else
      puts "My shot on #{@computer_shot} was a miss."
    end
  end

  def player_report
    player_shot_status =  @computer_board.cells[@player_shot].render
    if player_shot_status == "X"
      game.player_points += 1
      puts "Your shot on #{@player_shot} sunk my ship."
    elsif player_shot_status == "H"
        puts "Your shot on #{@player_shot} was a hit."
        game.player_points += 1
    else
      puts "Your shot on #{@player_shot} was a miss."
    end
  end
end
