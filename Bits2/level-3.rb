# --- A Class is an Object
class Game
  puts "I am inside the #{self} class"
end

# --- Refactoring Class Methods
class Game
  def self.find_by_title(name)
  end
end

# --- class_eval Part 1
Game.class_eval do
  def self.find_by_owner(name)
  end
end

# --- class_eval Part 2
class LibraryManager
  def self.make_available(klass, user)
    klass.class_eval do
      define_method "lend_to_#{user}" do
      end
    end
  end
end

# --- instance_eval Part 1
contra_game = Game.new('Contra')
contra_game.instance_eval do
  self.owner = "Alice"
end

# --- instance_eval Part 2
class Game
  def initialize(&block)
    instance_eval(&block) if block_given?
  end

  def owner(name=nil)
    if name
      @owner = name
    else
      @owner
    end
  end
end