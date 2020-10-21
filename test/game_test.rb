require 'minitest/autorun'
require 'minitest/pride'
require './lib/game'
require 'mocha/minitest'

class GameTest < Minitest::Test

  def test_it_exists_and_has_attributes
    game = Game.new
    assert_instance_of Game, game
  end
end
