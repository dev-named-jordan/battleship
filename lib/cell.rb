require './lib/ship'

class Cell
  attr_reader :coordinate,
              :ship

  def initialize(coordinate)
    @coordinate = coordinate
    @ship       = nil
    @taken_fire = false
  end

  def empty?
    @ship == nil
  end

  def place_ship(vessel)
    @ship = vessel
  end

  def fired_upon?
    @taken_fire == true
  end

  def fire_upon
    @taken_fire = true
      if @ship
        @ship.hit
      end
  end

  def render(show_ship_coordinates = false)
    if @ship != nil && @ship.sunk?
      "X"
    elsif fired_upon? && !empty?
      "H"
    elsif show_ship_coordinates == true && @ship != nil
      "S"
    elsif fired_upon? && empty?
      "M"
    else
       "."
    end
  end
end
