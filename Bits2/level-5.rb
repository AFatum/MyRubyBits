# --- The Game Class
class Game
  attr_reader :name
  
  def initialize(name)
    @name = name
  end
end

# --- The Library Class
class Library
  def initialize
    @games = []
  end
  
  def add_game(game)
    @games << game
  end
end

# --- Adding Games
LIBRARY = Library.new

def add_game(name)
  game = Game.new(name)
  LIBRARY.add_game(game)
end

# --- Initializing Game Data
class Game
  attr_reader :name

  def initialize(name)
    @name = name
    @year = nil
    @system = nil
  end

  # Add methods to store year and system
  def system(str)
    @system = str
  end
  
  def year(str)
    @year = str
  end
end

LIBRARY = Library.new
  def add_game(name, &block)
    game = Game.new(name)
    game.instance_eval(&block)
    LIBRARY.add_game(game)
  end

# --- Looking Up Games
LIBRARY = Library.new

def add_game(name, &block)
  game = Game.new(name)
  game.instance_eval(&block)
  LIBRARY.add_game(game)
end

def with_game(name, &block)
  game = LIBRARY.find_by_name(name)
  game.instance_eval(&block)
end

# --- Operating On Games
class Game
  attr_reader :name

  def initialize(name)
    @name = name
    @year = nil
    @system = nil
  end

  def year(value)
    @year = value
  end

  def system(value)
    @system = value
  end

  def print_details
    puts "#{@name} - #{@year} (#{@system})"
  end
  
  def play
  end
  
  def capture_screenshot
  end
end

# --- The Working DSL
add_game "Civilization" do
  system "PC"
  year 1991
end

add_game "Contra" do
  system "NES"
  year 1987
end

with_game "Contra" do
  print_details
  play
  capture_screenshot
end
