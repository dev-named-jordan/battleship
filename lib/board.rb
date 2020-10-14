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
    "1234".include?(number_array.join) || "11223344".include?(number_array.join) ||
    "111222333444".include?(number_array.join) ||
    "1111222233334444".include?(number_array.join)
  end


  # def valid_placement?(vessel, coordinates)
  #   if vessel.length == coordinates.length
  #   elsif coordinates.map do |coordinate|
  #     coordinate[0]
  # end

end
