#--- Struct
Game = Struct.new(:name, :year, :system)

#--- Extending Struct
Game = Struct.new(:name, :year, :system) do
  def to_s
    puts "name: #{:name}, year: #{:year}, system: #{:system}"
  end
end

#--- alias_method
class Library
  attr_accessor :games

  def each(&block)
    games.each(&block)
  end

  alias_method :each_game, :each
end

#--- define_method
class Game
  SYSTEMS = ['SNES', 'PS1', 'Genesis']

  attr_accessor :name, :year, :system

  SYSTEMS.each do |system|
    define_method "runs_on_#{system.downcase}?" do
      self.system == system
    end
  end
end

#--- send
library = Library.new(GAMES)
library.send(:list)
library.send(:emulate, "Contra")
game = library.send(:find, "Contra")

#--- public_send
class Library
  attr_accessor :games

  def initialize(games)
    self.games = games
  end

  def list
    puts games.join("\n")
  end

  def emulate(name)
    game = find(name)
    puts "Starting emulator for #{game}..."
  end

  protected

  def find(name)
    games.detect { |game| game.name == name }
  end
end

library = Library.new(GAMES)
library.public_send(:list)
library.public_send(:emulate, "Contra")
game = library.public_send(:find, "Contra")

#--- Looking Up Methods
library = Library.new(GAMES)
list = library.method(:list) 
emulate = library.method(:emulate) 

list.call
emulate.call("Contra")

#--- Refactoring

class Library
  attr_accessor :games

  def each(&block)
    games.each(&block)
  end

  def map(&block)
    games.map(&block)
  end

  def select(&block)
    games.select(&block)
  end
end

class Library
  attr_accessor :games

  [:each, :map, :select].each do |method|
    define_method(method) do |&block|
      games.send(method, &block)
    end
  end
end

