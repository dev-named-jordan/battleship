require 'minitest/autorun'
require 'minitest/pride'
require './lib/turn'
require 'mocha/minitest'

class TurnTest < Minitest::Test
  def test_it_exists_and_has_attributes
    turn = Turn.new
    assert_instance_of Turn, turn
    assert_equal Board, turn.computer_board.class
    assert_equal Board, turn.player_board.class
    assert_equal [], turn.player_has_fired_at
    assert_equal [], turn.computer_has_fired_at
    assert_equal 0, turn.computer_points
    assert_equal 0, turn.player_points
  end

  def test_player_shoots
    turn = Turn.new
    turn.stubs(:player_shot).returns("A1")
    turn.player_shoots

    assert_equal
  end
end
