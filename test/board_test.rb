require 'minitest/autorun'
require 'minitest/pride'
require './lib/board'

class BoardTest < Minitest::Test

  def test_it_exists_and_has_attributes
    #Consider adding an argument to Board for vertical and horizontal dimensions.
    board = Board.new
    require "pry"; binding.pry
    assert_instance_of Board, board
    assert_equal 16, board.cells.keys.length
    assert_equal Cell, board.cells.values[0].class
    assert_equal "A1", board.cells.keys[0]
  end
end
