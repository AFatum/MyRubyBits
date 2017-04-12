#---    Optional Arguments
def new_game(name, year=nil, system=nil)
  {
    name: name,
    year: year,
    system: system
  }
end
game = new_game("Street Figher II")

#---    Options Hash Argument
def new_game(name, options={})
  {
    name: name,
    year: options[:year],
    system: options[:system]
  }
end
game = new_game("Street Figher II", :system => "SNES", :year => 1992)

#---    Raise Exception
class InvalidGameError < StandardError; end
def new_game(name, options={})
  {
    name: name,
    year: options[:year],
    system: options[:system]
  }
  raise InvalidGameError.new unless name
end
begin
  game = new_game(nil)
rescue InvalidGameError => e
  puts "There was a problem creating your new game: #{e.message}"
end

#---    Splat Arguments
def describe_favorites(*games)
  for game in games
    puts "Favorite Game: #{game}"
  end  
end
describe_favorites('Mario', 'Contra', 'Metroid')

#---    Class
class Game
  def initialize(name, options={})
    @name = name
    @system = options[:system]
    @year = options[:year]
  end
end

#---    attr_accessor
class Game
  attr_accessor :name, :year, :system
  def initialize(name, options={})
    @name = name
    @year = options[:year]
    @system = options[:system]
  end
end

#---    attr_reader
class Game
  attr_accessor :name, :year, :system
  attr_reader :created_at

  def initialize(name, options={})
    @name = name
    @year = options[:year]
    @system = options[:system]
  end
  
  def created_at
    Time.now
  end
end

