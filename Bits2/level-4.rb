# --- method_missing Part 1
class Library
  def method_missing(method_name, *args)
    puts method_name
  end
end

# --- method_missing Part 2
class Library
  def method_missing(method_name, *args)
    puts method_name
    puts args
  end
end

# --- delegating Part 1
class Library
  def initialize(console)
    @manager = console
  end

  def method_missing(name, *args)
    @manager.send(name, *args)
  end
end

# --- delegating Part 2
class Library
  def initialize(console)
    @manager = console
  end

  def method_missing(name, *args)
    match = name.to_s.match(/atari/)
    if match
      @manager.send(name, *args)
    else
      super
    end
  end
end

# --- delegating Part 3
require 'delegate'

class Library < SimpleDelegator
  def initialize(console)
    super(console)
  end
end

# --- define_method Revisited
class Library
  SYSTEMS = ['arcade', 'atari', 'pc']

  attr_accessor :games

  def method_missing(name, *args)
    system = name.to_s
    if SYSTEMS.include?(system)
      self.class.class_eval do
        define_method(system) do
          find_by_system(system)
        end
      end
      send(system)
    else
      super
    end

  end

  private

  def find_by_system(system)
    games.select { |game| game.system == system }
  end
end

# --- respond_to?
class Library
  SYSTEMS = ['arcade', 'atari', 'pc']

  attr_accessor :games

  def method_missing(name, *args)
    system = name.to_s
    if SYSTEMS.include?(system)
      self.class.class_eval do
        define_method(system) do
          find_by_system(system)
        end
      end
      send(system)
    else
      super
    end
  end
  
  def respond_to?(name)
    SYSTEMS.include?(name.to_s) || super
  end

  private

  def find_by_system(system)
    games.select { |game| game.system == system }
  end
end
