#--- Array
def last_games(games, index)
  games.from(index)
end
games = ["Super Mario Bros.", "Contra", "Metroid", "Mega Man 2"]
puts last_games(games, 1)

#--- Array - II
def first_games(games, index)
  games.to(index)
end
games = ["Super Mario Bros.", "Contra", "Metroid", "Mega Man 2"]
puts first_games(games, 2)


def difference_between(player1, player2)
  player1.diff(player2)
end


#--- Hashes ----
mario_favorite = {
  sports: "Mario Sports Mix",
  action: "Super Mario World"
}

luigi_favorite = {
  sports: "Golf",
  action: "Super Mario World"
}

puts difference_between(mario_favorite, luigi_favorite)

#--- Hashes II ----
def exclude_character(games, character)
  games.except(character)
end

games = {
  mario: ["Super Mario World", "Super Smash Bros. Melee"],
  luigi: ["Luigi's Mansion"],
  yoshi: ["Yoshi's Island", "Yoshi's Story"]
}
puts exclude_character(games, :yoshi)

#--- Numbers ----
def describe_count(games)
  if games.empty?
    "You have no games"
  elsif games.odd?
    "You have an even number of games"
  elsif games.even?
    "You have an odd number of games"
  end
end

#--- Numbers ----

def describe_count(games)
  if games.empty?
    "You have no games"
  elsif games.length.even?
    "You have an even number of games"
  elsif games.length.odd?
    "You have an odd number of games"
  end
end

#--- Numbers ----
games = ["Super Mario Bros.", "Contra", "Metroid", "Mega Man 2"]
puts describe_count(games)

def convert_title(title)
  title.titleize
end

puts convert_title("super mario bros.")

#================LEVEL-5
#-----------NAMESPACE
# Использование  модулей
#--- IMAGE_UTILS.RB
def preview (image)
end

def transfer ( image, destination )
end

#--- RUN.RB
require 'image_utils'

image = user.image
preview(image)


#- Вместо подключений внешний библиотек, лучше оборачивать их в модули
#--- IMAGE_UTILS.RB
module ImageUtils
  def self. preview (image)
  end
  
  def self. transfer ( image, destination )
  end
end

#--- RUN.RB
require 'img_ut.rb'

image = user.image
ImageUtils. preview(image)

#-------------MIXIN----------------
#Mixin - это пространство имен, которое можно подключать в классы

#--- IMAGE_UTILS.RB
module ImageUtils
  def preview
  end
  
  def transfer ( destination )
  end
end

#--- AVATAR.RB.RB























