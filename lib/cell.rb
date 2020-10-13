require './lib/ship'

class Cell
  attr_reader :coordinate, :ship

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
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

  def fired_upon
    @taken_fire = true
    @ship.hit
  end
end
