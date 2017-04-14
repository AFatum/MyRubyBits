#--- Iterating with Blocks
class Library
  attr_accessor :games

  def initialize(games = [])
    self.games = games
  end

  def list
    games.each { |game| puts game.name }
  end
end

#--- Yielding to Blocks
class Library
  attr_accessor :games

  def initialize(games = [])
    self.games = games
  end

  def each_on_system(system)
    @games.each do |game|
      yield if game.system == system
    end
  end
end

#--- Passing Arguments to Blocks
class Library
  attr_accessor :games

  def initialize(games = [])
    self.games = games
  end

  def each_on_system(system)
    @games.each do |game|
      yield game if game.system == system
    end
  end
end

#--- Passing Arguments to Blocks