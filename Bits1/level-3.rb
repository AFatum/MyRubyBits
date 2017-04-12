#--- Collection Class
# add your code here
class Library
  attr_accessor :games
  def initialize(games)
    @games = games
  end
end

#--- Encapsulation
class Library
  attr_accessor :games

  def initialize(games)
    self.games = games
  end
  
  def has_game?(name)
    for game in games
      return true if name == game
    end
    false
  end
end

#--- Instance Method
class Library
  attr_accessor :games

  def initialize(games)
    self.games = games
  end

  def has_game?(search_game)
    for game in games
      return true if game == search_game
    end
    false
  end
  
  def add_game(name)
    self.games << name
  end
end

#--- Private Method
class Library
  attr_accessor :games

  def initialize(games)
    self.games = games
  end

  def has_game?(search_game)
    for game in games
      return true if game == search_game
    end
    false
  end

  def add_game(game)
    log(game)
    games << game
  end
  
  private
  def log(game)
    puts game
  end
end

#--- Inheritance
class ArcadeGame < Game
end

class ConsoleGame < Game
end

#--- Inheritance II
class ArcadeGame < Game
  attr_accessor :weight
  def initialize (name, options={}) 
    super
    self.weight = options[:weight]
  end
end
class ConsoleGame < Game
end

#--- Inheritance III
class ConsoleGame < Game
  def to_s
   "#{self.name} - #{self.system}"
  end
end

#--- Refactoring
class Game
  attr_accessor :name, :year, :system
  attr_reader :created_at
  def initialize(name, options={})
    self.name = name
    self.year = options[:year]
    self.system = options[:system]
    @created_at = Time.now
  end

  def to_s
    self.name
  end

  def description
    to_s + " was released in #{self.year}."
  end
end

class ConsoleGame < Game
  def to_s
    "#{self.name} - #{self.system}"
  end

  def description
    to_s + " was released in #{self.year}."
  end
end


#----------------
class Game
  attr_accessor :name, :year, :system
  attr_reader :created_at
  def initialize(name, options={})
    self.name = name
    self.year = options[:year]
    self.system = options[:system]
    @created_at = Time.now
  end
end

---
class Game
  attr_accessor :name, :year, :system
  attr_reader :created_at
  def initialize(name, options={})
    self.name = name
    self.year = options[:year]
    self.system = options[:system]
    @created_at = Time.now
  end

  def to_s
    self.name
  end

  def description
    "#{self} was released in #{self.year}."
  end
end

class ConsoleGame < Game
  def to_s
    "#{self.name} - #{self.system}"
  end

  def description
    "#{self.name} - #{self.system} was released in #{self.year}."
  end
end

---
  

class Game
  attr_accessor :name, :year, :system
  attr_reader :created_at
  def initialize(name, options={})
    self.name = name
    self.year = options[:year]
    self.system = options[:system]
    @created_at = Time.now
  end

  def to_s
    self.name
  end

  def description
    "#{self} was released in #{self.year}."
  end
end

class ConsoleGame < Game
  def to_s
    "#{self.name} - #{self.system}"
  end
end