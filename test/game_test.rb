require 'minitest/autorun'
require 'minitest/pride'
require './lib/game'
require 'mocha/minitest'

class GameTest < Minitest::Test

  def test_it_exists_and_has_attributes
    game = Game.new

    assert_instance_of Game, game
    assert_equal Board, game.computer_board.class
    assert_equal Board, game.player_board.class
    assert_equal [], game.player_has_fired_at
    assert_equal [], game.computer_has_fired_at
    assert_equal 0, game.computer_points
    assert_equal 0, game.player_points
    assert_equal Ship, game.computer_cruiser.class
    assert_equal Ship, game.computer_submarine.class
    assert_equal Ship, game.human_cruiser.class
    assert_equal Ship, game.human_submarine.class
  end

  def test_computer_setup
    game = Game.new
    game.stub(:valid_placement?).returns(true)
    assert_equal
end
