Dir[File.expand_path('lib/*.rb', File.dirname(__FILE__))].each do |file|
  require file
end

require 'pry'

game = Game.new
game.start
