require 'minitest/autorun'
require 'minitest/pride'
require './lib/board'

class BoardTest < Minitest::Test

  def test_it_exists_and_has_attributes
    #Consider adding an argument to Board for vertical and horizontal dimensions.
    board = Board.new
    assert_instance_of Board, board
    assert_equal 16, board.cells.keys.length
    assert_equal Cell, board.cells.values[0].class
    assert_equal "A1", board.cells.keys[0]
  end

  def test_valid_coordinates
    board = Board.new

    assert_equal true, board.valid_coordinate?("A1")
    assert_equal true, board.valid_coordinate?("D4")
    assert_equal false, board.valid_coordinate?("A5")
    assert_equal false, board.valid_coordinate?("E1")
    assert_equal false, board.valid_coordinate?("A22")
  end

  def test_valid_placement?
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    actual = board.valid_placement?(cruiser, ["A1", "A2"])
    assert_equal false, actual

    actual2= board.valid_placement?(cruiser, ["A1", "A2", "A3"])
    assert_equal true, actual2
  end
end
