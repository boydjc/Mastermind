require './player.rb'
require './computer.rb'

class Game
  def initialize()
    @secretCode = []
	@computer = Computer.new()
	@player = Player.new()
  end
end
