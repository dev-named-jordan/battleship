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

  def test_consecutive_letters #Make more tests for larger ships.
    board = Board.new

    assert_equal true, board.consecutive_letters?(["A1", "A2"])
    assert_equal true, board.consecutive_letters?(["A1", "B1"])
    assert_equal false, board.consecutive_letters?(["A1", "C1"])
    assert_equal false, board.consecutive_letters?(["A1", "D1"])
  end

  def test_consecutive_numbers
    board = Board.new

    assert_equal true, board.consecutive_numbers?(["A1", "A2"])
    assert_equal true, board.consecutive_numbers?(["A2", "A3"])
    assert_equal false, board.consecutive_numbers?(["A1", "A3"])
    assert_equal false, board.consecutive_numbers?(["A4", "A1"])
  end

  def test_valid_placement?
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    actual = board.valid_placement?(cruiser, ["A1", "A2"])
    assert_equal false, actual

    actual2 = board.valid_placement?(cruiser, ["A1", "A2", "A3"])
    assert_equal true, actual2
    actual3 = board.valid_placement?(cruiser, ["A1", "A2", "A4"])
    assert_equal false, actual3
    actual4 = board.valid_placement?(submarine, ["B1", "C1"])
    assert_equal true, actual4
    actual5 = board.valid_placement?(submarine, ["A1", "C1"])
    assert_equal  false, actual5
    actual6 = board.valid_placement?(submarine, ["C1", "B1"])
    assert_equal false, actual6
    actual7 = board.valid_placement?(cruiser, ["A3", "A2", "A1"])
    assert_equal false, actual7
    actual8 = board.valid_placement?(cruiser, ["A1", "B2", "C3"])
    assert_equal false, actual8
    actual9 = board.valid_placement?(submarine, ["C2", "D3"])
    assert_equal false, actual9
  end
end
