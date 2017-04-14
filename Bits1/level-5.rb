#--- Namespacing
module GameUtils
  def self.lend_to_friend(game, friend_email)
  end
end

game = Game.new("Contra")
GameUtils.lend_to_friend(game, "gregg@codeschool.com")

#--- Mixin
class Game
  include GameUtils
end
game = Game.new("contra")
game.lend_to_friend("Gregg")

#--- Mixin
class Game
  include GameUtils
end

Game.find_all_from_user("Gregg")

#--- Extend
class Game
  extend GameUtils
end

Game.find_all_from_user("Gregg")

#--- Extend
class Game
  include Playable
end
game = Game.new("Contra")
game.play

#-- Object Extend
game = Game.new("Contra")
game.extend(Playable)
game.play

#--- Hook Methods
module LibraryUtils

  def add_game(game)
  end

  def self.included(base)
    base.extend(ClassMethods)
  end
  
  def remove_game(game)
  end

  module ClassMethods
    def search_by_game_name(name)
    end
  end
end

class AtariLibrary
  include LibraryUtils
end

#--- ActiveSupport::Concern - Part I
module LibraryUtils

  extend ActiveSupport::Concern

  def add_game(game)
  end

  def remove_game(game)
  end

  module ClassMethods
    def search_by_game_name(name)
    end
  end
end

#--- ActiveSupport::Concern - Part II
module LibraryUtils

  extend ActiveSupport::Concern

  included do
    load_game_list
  end
  
  def add_game(game)
  end

  def remove_game(game)
  end

  module ClassMethods
    def search_by_game_name(name)
    end

    def load_game_list
    end
  end
end

#--- ActiveSupport::Concern - Part III
module LibraryLoader

  extend ActiveSupport::Concern

  module ClassMethods
    def load_game_list
    end
  end
end

module LibraryUtils
  extend ActiveSupport::Concern
  include LibraryLoader
  
  included do
    load_game_list
  end

end

class AtariLibrary
  include LibraryUtils
end