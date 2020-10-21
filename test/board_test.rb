require 'minitest/autorun'
require 'minitest/pride'
require './lib/board'

class BoardTest < Minitest::Test

  def test_it_exists_and_has_attributes
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

  def test_letter_array
    board = Board.new

    assert_equal ["A", "A"], board.letter_array(["A1", "A2"])
    assert_equal ["A", "B", "C"], board.letter_array(["A1", "B2", "C3"])
  end

  def test_number_array
    board = Board.new

    assert_equal ["1", "2"], board.number_array(["A1", "A2"])
    assert_equal ["1", "2", "3"], board.number_array(["A1", "B2", "C3"])
  end

  def first_two_letters?
    board = Board.new

    assert_equal true, board.first_two_letters?(["A1", "A2"])
    assert_equal false, board.first_two_letters?(["A1", "B1"])

  end

  def last_two_letters?
    board = Board.new

    assert_equal true, board.last_two_letters?(["A1", "A2", "A3"])
    assert_equal false, board.last_two_letters?(["A1", "B1", "C1"])
  end

  def first_two_numbers?
    board = Board.new

    assert_equal true, board.first_two_numbers?(["A1", "B1", "C1"])
    assert_equal false, board.first_two_numbers?(["A1", "A2", "A3"])
  end

  def last_two_numbers?
    board = Board.new

    assert_equal true, board.last_two_numbers?(["A1", "B1", "C1"])
    assert_equal false, board.last_two_numbers?(["A1", "A2", "A3"])
  end

  def test_consecutive_letters
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

  def test_no_diagonals?
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    actual1 = board.valid_placement?(cruiser, ["A1", "B2", "C3"])
    assert_equal false, actual1
    actual2 = board.valid_placement?(submarine, ["C1", "D1"])
    assert_equal true, actual2
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

    board.place(cruiser, ["A1", "A2", "A3"])

    actual10 = board.valid_placement?(submarine, ["A1", "B1"])
    assert_equal false, actual10
    actual11 = board.valid_placement?(submarine, ["B1", "B2"])
    assert_equal true, actual11
  end

  def test_can_place_a_ships
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)

    board.place(cruiser, ["A1", "A2", "A3"])

    cell_1 = board.cells["A1"]
    cell_2 = board.cells["A2"]
    cell_3 = board.cells["A3"]

    assert_equal cruiser, cell_1.ship
    assert_equal cruiser, cell_2.ship
    assert_equal cruiser, cell_3.ship
    assert_equal true, cell_3.ship == cell_2.ship
  end

  def test_for_no_overlapping
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)

      board.place(cruiser, ["A1", "A2", "A3"])
      assert_equal true, board.no_overlapping?(["B1", "C1"])
      assert_equal false, board.no_overlapping?(["A1", "B1"])
  end

  def test_create_row
    board = Board.new
    assert_equal ". . . .", board.create_row(0..3)
    cruiser = Ship.new("Cruiser", 3)
    board.place(cruiser, ["A1", "A2", "A3"])
    assert_equal "S S S .", board.create_row(0..3, true)
  end

  def test_render
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    board.place(cruiser, ["A1", "A2", "A3"])
    expected1 = " 1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n"
    assert_equal expected1, board.render

    expected2 = " 1 2 3 4 \nA S S S . \nB . . . . \nC . . . . \nD . . . . \n"
    assert_equal expected2, board.render(true)

    board.cells.values[0].fire_upon
    board.cells.values[4].fire_upon

    expected3 = " 1 2 3 4 \nA H S S . \nB M . . . \nC . . . . \nD . . . . \n"
    assert_equal expected3, board.render(true)
    expected4 = " 1 2 3 4 \nA H . . . \nB M . . . \nC . . . . \nD . . . . \n"
    assert_equal expected4, board.render

    board.cells.values[1].fire_upon
    board.cells.values[2].fire_upon
    expected5 = " 1 2 3 4 \nA X X X . \nB M . . . \nC . . . . \nD . . . . \n"
    assert_equal expected5, board.render
    assert_equal expected5, board.render(true)
  end
end
