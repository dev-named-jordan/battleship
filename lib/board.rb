require './lib/cell'

class Board
  attr_reader :cells

  def initialize#arguments here for vertical/ horizontal
    @cells = {
      "A1" => Cell.new("A1"),
      "A2" => Cell.new("A2"),
      "A3" => Cell.new("A3"),
      "A4" => Cell.new("A4"),
      "B1" => Cell.new("B1"),
      "B2" => Cell.new("B2"),
      "B3" => Cell.new("B3"),
      "B4" => Cell.new("B4"),
      "C1" => Cell.new("C1"),
      "C2" => Cell.new("C2"),
      "C3" => Cell.new("C3"),
      "C4" => Cell.new("C4"),
      "D1" => Cell.new("D1"),
      "D2" => Cell.new("D2"),
      "D3" => Cell.new("D3"),
      "D4" => Cell.new("D4")
      }
    @occupied_cells = []
  end

  def valid_coordinate?(coordinate)
    @cells.keys.include?(coordinate)
  end

  def consecutive_letters?(coordinates)
    letter_array = coordinates.map do |coordinate|
      coordinate[0]
    end
    "AABBCCDD".include?(letter_array.join) || "ABCD".include?(letter_array.join) ||
    "AAABBBCCCDDD".include?(letter_array.join) ||
    "AAAABBBBCCCCDDDD".include?(letter_array.join)
  end

  def consecutive_numbers?(coordinates)
    number_array = coordinates.map do |coordinate|
      coordinate[1]
    end
    ("1234".include?(number_array.join) || "11223344".include?(number_array.join) ||
    "111222333444".include?(number_array.join) ||
    "1111222233334444".include?(number_array.join))

  end

  def no_diagonals?(coordinates)
    letter_array = coordinates.map do |coordinate|
      coordinate[0]
    end
    number_array = coordinates.map do |coordinate|
      coordinate[1]
    end
    letter_array[0] == letter_array[1] || number_array[0] == number_array[1]
  end

  def valid_placement?(vessel, coordinates)
    vessel.length == coordinates.length &&
    (consecutive_numbers?(coordinates) &&
    consecutive_letters?(coordinates)) &&
    no_diagonals?(coordinates) && no_overlapping?(coordinates)
  end

  def place(ship, coordinates)
    coordinates.each do |coordinate|
      @cells[coordinate].place_ship(ship)
    end
    @occupied_cells << coordinates
    @occupied_cells = @occupied_cells.flatten
  end

  def no_overlapping?(coordinates)
    inclusion_array = coordinates.map do |coordinate|
      @occupied_cells.include?(coordinate)
    end
    if inclusion_array.include?(true)
      false
    else
      true
    end
  end

  def create_row(range)
    row1 = @cells.values.slice(range).map do |cell|
      cell.render
    end.join(" ")
  end

  def render(show_ships = false)
      row1 = create_row(0..3)
      row2 = create_row(4..7)
      row3 = create_row(8..11)
      row4 = create_row(12..15)
      " 1 2 3 4 \nA " + row1 + " \nB " + row2 + " \nC " + row3 + " \nD " + row4 + " \n"
  end
end
