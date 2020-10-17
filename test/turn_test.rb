require 'minitest/autorun'
require 'minitest/pride'
require './lib/turn'

class TurnTest < Minitest::Test
  def test_it_exists_and_has_attributes
    turn = Turn.new
    assert_instance_of Turn, turn
  end

  def test_computer_setup
    turn = Turn.new
    turn.computer_setup

    assert_equal
  end
end
