# --- Procs
class Library
  attr_accessor :games

  def initialize(games)
    @games = games
  end

  def exec_game(name, action)
    game = games.detect { |game| game.name == name }
    action.call(game)
  end
end

library = Library.new(GAMES)
print_details = Proc.new do |game|
  puts "#{game.name} (#{game.system}) - #{game.year}"
end
library.exec_game("Contra", print_details)

# --- Lambdas
library = Library.new(GAMES)
print_details = lambda do |game|
  puts "#{game.name} (#{game.system}) - #{game.year}"
end
library.exec_game('Contra', print_details)

# --- Multiple Lambdas
class Library
  attr_accessor :games

  def initialize(games)
    @games = games
  end

  def exec_game(name, action, error_handler)
    game = games.detect { |game| game.name == name }
    begin
      action.call(game)
    rescue
      error_handler.call
    end
  end
end

# --- Proc to Block
library = Library.new(GAMES)
block = lambda { |game| puts "#{game.name} (#{game.system}) - #{game.year}" }
library.each(&block)

# --- Capturing Blocks
class Library
  attr_accessor :games

  def initialize(games)
    @games = games
  end

  def each(&block)
    games.each(&block)
  end
end

# --- Passing Blocks
class Library
  attr_accessor :games

  def initialize(games)
    @games = games
  end

  def each(&block)
    games.each(&block)
  end
end

# --- Symbol#to_proc
class Library
  attr_accessor :games

  def initialize(games)
    @games = games
  end

  def names
    games.map(&:name)
  end
end

# --- Optional Blocks
class Library
  attr_accessor :games

  def initialize(games)
    @games = games
  end

  def list
    games.each do |game|
      if block_given?
        puts yield game
      else
        puts game.name
      end
    end
  end
end
