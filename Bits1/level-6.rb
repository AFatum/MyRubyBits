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
class Timeline
  def each
    @user.friends.each do |friend|
      friend.tweets.each { |tweet| yield tweet }
    end
  end
end

#--- Returning Values from Blocks
class Library
  attr_accessor :games

  def initialize(games = [])
    self.games = games
  end

  def list
    @games.each do |game|
      puts yield game
    end
  end
end

#--- Using Enumerable
class Library
  attr_accessor :games

  def initialize(games = [])
    self.games = games
  end

  def each
    @games.each do |game|
      yield game
    end
  end
  include Enumerable  
end


#--- Refactoring with Blocks
class Game
  attr_accessor :name, :year, :system
  attr_reader :created_at

  def initialize(name, options={})
    self.name = name
    self.year = options[:year]
    self.system = options[:system]
    @created_at = Time.now
  end

  def play
    emulate { |em| em.play(self) }
  end

  def screenshot
    emulate do |em| 
      em.start(self) 
      em.screenshot 
    end
  end

  private
  def emulate
    begin
      emulator = Emulator.new(system)
      yield emulator
    rescue Exception => e
      puts "Emulator failed: #{e}"
    end
  end
end