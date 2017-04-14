# - плохой код и хороший код
# - пример плохого кода
if ! tweets.empty?
  puts "Timeline:"
  puts tweets
end

=begin
Здесь код является плохим, потому использовано if ! .
Если нам нужно использовать отрицательное условие, когда что-то неравно чему-то,
то лучше использовать условный оператор - unless 
=end
#- лучше писать код так
unless tweets.empty?
  puts "Timeline:"
  puts tweets
end

#- импользование unless вместе с else
#- вместо этого,
unless tweets.empty?
  puts "Timeline:"
  puts tweets
else
  put "No tweets found - better follow some people"
end

#- нужно писать так:
if tweets.empty?
  put "No tweets found - better follow some people"
else
  puts "Timeline:"
  puts tweets
end

# - nil is false
#-
if attachment.file_path != nil
  attachment.post
end


#+ - здесь можно не сравнивать с нулем, т.к. если значение верно, оно вернет не false 
if attachment.file_path
  attachment.post
end

# - пустые значения, возвращают true
"" #=> пустая строка вернет true
0 #=> число ноль вернет true
[] #=> пустой массив также вернет true

# - поэтому вот так писать НЕ нужно
unless name.length
  warn "User name required"
end
# потому что даже если строка пустая, то всё равно условие будет всегда истинным

# вместо такой конструкции,..
if password.lenght < 8
  fail "Password too short"
end
unless username
  fail "No user name set"
end
#.. лучше использовать однострочные if/unless
fail "Password too short" if password.lenght < 8
fail "No user name set" unless username

# использование оператора &&
# так НЕ надо
if user
  if user.signed_in?
    #...
  end
end
# надо ТАК
if user && user.signed_in?
  #...
end

# использование or (||) в присваивании
# всегда вернется первое истинное значение
res = nil || 1  #=> 1
res = 1 || nil  #=> 1
res = 1 || 2    #=> 1
# например это можно использовать в присвоении значения по-умолчанию
# присваиваем значение пустому массиву
# так НЕ надо
tweets = timeline.tweets
tweets = [] unless tweets
# надо ТАК
tweets = timeline.tweets || []

# короткое сравнительное определение
# это определение короткое, но if/else, было бы более понятным
def sign_in
  current_session || sign_user_in
end

# таким образом с помощью оператора || мы можем устанавливать значения по-умолчанию
i_was_set = 1
i_was_set ||= 2
#=> 1, здесь эта конструкция вернет 1, потому что есть основное значение,.
#.. но если бы основное значение (вместо 1) было бы равно false или nil,.
#.. тогда бы переменная имела бы значение 2.
i_was_set ||= 3
# Здесь, как мы видим, в любой момент, с помощью того же оператора ||.. 
#.. можно изменить значение по-умолчанию, у нас 2 меняется на 3.

# ещё один пример использования || - присваивание значения по-умолчанию для массивов
# так НЕ надо
option[:country]    = 'us' if option[:country].nil?
option[:privacy]    = true if option[:privacy].nil?
option[:geotag]     = true if option[:geotag].nil?
# надо ТАК
option[:country] ||= 'us'
option[:privacy] ||= true
option[:geotag]  ||= true

# ruby всегда возвращает какое-то значение, поэтому для более упрощения..
#.. рефакторинга, нужно учитывать это и применять упрощённое присваивание:
# так НЕ надо
if list_name
    option[:path] = "/#{user_name}/#{list_name}"
else
    option[:path] = "/#{user_name}"
end
# надо ТАК
option[:path] = if list_name
    "/#{user_name}/#{list_name}"
else
    option[:path] = "/#{user_name}"
end

# и ещё один пример применение в методе (функции)
# так НЕ надо
def list_url(user_name, list_name)
    if list_name
        url = "https://twitter.com/#{user_name}/#{list_name}"
    else
        url = "https://twitter.com/#{user_name}"
    end
    url
end
# надо ТАК
def list_url(user_name, list_name)
    if list_name
        "https://twitter.com/#{user_name}/#{list_name}"
    else
        "https://twitter.com/#{user_name}"
    end
end
# в этом примере мы видим, что можно обойтись без локальной переменной url вовсе!

# применение более читабельного case
tweet_type = case tweet.status
    when /\A@\w+/       then :mention
    when /\Ad\s+\w+/    then :direct_message
     else               then :public
end
#================ Level-2
#1. Опциональные аргументы. 
#2. хеш-аргументы.

def tweet(message, options = {})
    status = Status.new
    status.lat  = option{:lat}
    status.long = option{:long}
    status.body = massage
    status.replay_id = option{:replay_id}
    status.post
end
#использование метода
tweet("Practicing Ruby-Fu!",
    :lat => 28.55,
    :long => 81.33,
    :reply_id => 227946,
    )   
        
# Использование исключений
def get_tweets(list)
    unless list.authorized?(@user)
        raise AutorizationException.new
        # raise как throw в php
    end
    list.tweets
end
        
begin # как try в php
    tweets = get_tweets(my_list)
rescue AutorizationException # как catch в php
    warn "You are..."
end


        
       def describe_favorites(*games)
  for game in games
    puts "Favorite Game: #{game}"
  end
end
describe_favorites('Mario', 'Contra', 'Metroid') 
        
        
class Game
  attr_accessor :name, :year, :system
  def initialize(name, options={})
    @name = name
    @year = options[:year]
    @system = options[:system]
  end
end
        
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

#===================-Level-3-=========================
# ENCAPSULATION - инкапсуляция в руби подразумевая использование объектов определенных классов в качестве аргументов для каких-то методов. Это позволяет уменьшить количество передаваемых аргументов в методе до одного объекта этого класса, и использовать все его методы для работы в методе, в котором передается аргументом. Пример
#------ Так не надо
send_tweet("Practicing Ruby-Fu!", 14)

def send_tweet(status, owner_id)
 retrieve_user(owner_id)
 ...
end

#----- Нужно так
#- создаём объект нужного класса
tweet = Tweet.new
#- задаём ему все необходиые параметры
tweet.status = "Practicing Ruby-Fu!"
tweet.owner_id = curr
#- далее передаём его аргументом в метод и работаем уже там внутри, отдельно
def send_tweet(message)
 message.owner
 ...
end
#- потому что сам метод Tweet уже содержит в себе мпетод retrieve_user(owner_id)
class Tweet
 attr_accessor ... 
 def owner
 retrieve_user(owner_id)
 end
end
        
#---------------VISIBILITY----------------------------
# области видимости. Для создания API вместо private, целесообразно использовать protected
class User
  def up_vote(friend)
    bump_karma
    friend.bump_karma
  end
# здесь если мы заприватим этот метод то вместе с нежелательными пользователями, к нему доступ не будут иметь и наследники класса
private
def bump_karma
puts "karma up for #{name}"
end

# поэтому, чтоб отсеить доступ к методу извне, но позволить использовать наследникам, используют protected
class User
  def up_vote(friend)
    bump_karma
    friend.bump_karma
  end
    
  protected
  def bump_karma
    puts "karma up for #{name}"
  end
end
#---------------INHERITANCE----------------------------
# наследование лучше использовать для избегание дублирования функционала. Рассмотрим пример наличия двух похожих классов с одиннаковыми переменными и методами:
class Image
  attr_accessor :title, :size, :url
  def to_s
    "#{@title}, {@size}"
  end
end
  
class Video
  attr_accessor :title, :size, :url
  def to_s
    "#{@title}, {@size}"
  end
end

# вместо вышеуказанных классов, целесообразно использовать наследников от одного родительского класса

class Attachment
  attr_accessor :title, :size, :url
  def to_s
    "#{@title}, #{@size}"
  end
end

class Image < Attachment
end
  
class Video < Attachment
  # каждый отдельный наследник может иметь свои отличия
  attr_accessor :duration
end
  
#---------------SUPER----------------------------
# здесь используем ключевое слово super, чтоб получить доступ к родительским методам, и переменным
# важно помнить, что при переназначении методов в дочерних классах, всё исполнение родительского класса пропадает, и заменяется исполнением дочернего.
# и если нам нужно использовать исполнение родительского класса для его дополнения в дочернем, нам нужно это явно указать в описании метода через слово super, пример:

# есть родительский класс
class User
  def initialize(name)
    @name = name
  end
end

class Follower < User
  def initialize(name, following)
    # - здесь, чтоб получить доступ к родительской переменной name, используется super
    @following = following
    super(name)
  end
  def relationship
    "#{@name} follows #{@following}"
  end
end
  
# также можно исползьзовать одновременное исполнение родительского и дочернего метода, при необходимости:  
class Grandparent
  def my_method(arg)
  "Grandparent: my_method called - #{arg}"
  end
end

class Parent < Grandparent
end

class Child < Parent
  def my_method(arg)
    string = super
    "#{string}\nChild: my_method called - #{arg}"
  end
end

#---------------OVERRIDING METHODS----------------------------
# переопределение методов, хорошо использовать вместо нагромождение функционала в одном методе через case:
# Вместо такого варианта..
class Attachment
  def preview
    case @type
    when :jpg, :png, :gif
      thumbnail
    when :mp3
      player
    end
  end
end

#.. лучше использовать вот такой:
# исходный класс
class Attachment
  def preview
    thumbnail
  end
end

# класс-наледник, для расширение функционала
class Audio < Attachment
  def preview
    player
  end
end
# - такой подход ускоряет производительность, т.к. нет необходимости перебирать все возможные варианты функционала, для выбора нужного, как в предыдущем примере.
  
#---------------HIDE INSTANCE VARIABLES----------------------------
# если нам нужно использовать одинаковы участки кода в рамках одного класса из разных методов, то лучше вместо нагромождение одинакового кода, как в этом примере..
  
class User
  def tweet_header
    [@first_name, @last_name].join(' ')
  end
  
  def profile
    # повтор перечисленных параметров
    [@first_name, @last_name].join(' ') + @description
  end
end

# здесь вместо того, чтоб не повторять код, можно просто испольовать результат переменной
class User
  def display_name
    [@first_name, @last_name].join(' ')
  end
  
  def tweet_header
    display_name
  end
  
  def profile
    display_name + @description
  end
end
  
#---------------Arrays----------------------------
array = [0, 1, 2, 3, 4, 5, 6]
# возврат значения с определенной позиции
array.from(4) #=> [4, 5, 6]
# возврат значения ДО определенной позиции
array.to(2) #=> [0, 1, 2]
# группировка элементов массива по указанному значению (с nil)
array.in_groups_of(3) #=> [0, 1, 2], [3, 4, 5], [6, nil, nil]
# разделение массива, начиная с определенной позиции
array.split(2) #=> [0, 1], [2, 3, 4, 5, 6]
  

#---------------Date----------------------------
app = DateTime.new(2012, 12, 21, 14, 27, 45)
#=> Fri, 21 Dec 2012 14:27:45 +0000
app.at_beginning_of_day   #=> вернет значение с начала дня
#=> Fri, 21 Dec 2012 00:00:00 +0000
app.at_end_of_month       #=> вернет значение до конца месяца 
#=> Mon, 31 Dec 2012 23:59:59 +0000
app.at_beginning_of_year  #=> вернет значение с начала года
#=> Sun, 01 Jan 2012 00:00:00 +0000

app.advance(years: 4, month: 3, weeks: 2, days: 1)  
#=> вернет значение заданной даты плюс указанный период в аргументе
#=> Wed, 05 Apr 2017 14:27:45 +0000

app.tomorrow #=> вернет завтрешний день, от указанной даты
#=> Sat, 22 Dec 2012 14:27:45 +0000
app.yesterday #=> вернет вчерашний день, от указанной даты
#=> Thu, 20 Dec 2012 14:27:45 +0000

#---------------HASH----------------------------
# есть пример отображения двух хешей
options = {user: 'codeschool', lang: 'fr'}
new_options = {user: 'codeschool', lang: 'fr', password: 'dunno'}
# определение разницы между двумя вышеуказанными хешами
options.diff(new_options) #=> {:password=>"dunno"}
  
# преобразование символов хеша в строки
options.stringify_keys #=> {"user"=>"codeschool", "lang"=>"fr"}

#---------------Объединение хешей---------------------------
# пример хешей
options = {
lang: 'fr',
user: 'codeschool'
}

defaults = {
lang: 'en',
country: 'us'
}

#объединям
options.reverse_merge(defaults)
#получаем:
{
lang: 'fr',
user: 'codeschool',
country: 'us'
}

$ gem install activesupport
$ gem install i18n
require 'active_support/all'
#---------------Объединение хешей---------------------------
#---------------CORE EXTENSIONS: INTEGER---------------------------
def background_class(index)
  return 'white' if index.odd?
  return 'grey' if index.even?
end
# - благодаря методам .odd, и .even, мы можем возвращать четные и нечетные значения при исполнении итераторов, пример:
tweets.each_with_index do |tweet, index|
  puts "<div class='#{background_class(index)}'>#{tweet}</div>"
end
# получаем зебру
=begin
  <div class='grey'>I had eggs for breakfast.</div>
  <div class='white'>@codeschool pwns.</div>
  <div class='grey'>Shopping!</div>
  <div class='white'>Bedtime.</div>
=end
#---------------INFLECTOR---------------------------
# - используются для преобразования строк, под определенные шаблоны, например:
# - преобразование порядкового значения числа в строку:
"#{1.ordinalize} place!"  # => "1st place!"
"#{2.ordinalize} place."  # => "2nd place!"
"#{23.ordinalize} place." # => "23rd place!"

# pluralize  - преобразовывает строку единственного числа, во множественное
"user".pluralize    #=> "users"
"octopus".pluralize #=> "octopi"
# singularize  -  наоборот, преобразовывает строку множественного числа, в единственное
"women".singularize #=> "woman"

"ruby bits".titleize #=> Всё с большой буквы "Ruby Bits"
"account_options".humanize #=> "Account options"

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
require 'image_utils'
class Image
  # подключение модуля
  include ImageUtils
end

#mixin целесообразно использовать вместо классаов-родителей, когда необходимо от одного класса наследовать несколько классов, рассмотрим пример:
#есть класс-родитель - 
class Shareable
  def share_on_facebook
  end
end

# и от него наследуются несколько дочерних классов:

class Post < Shareable
  def share_on_facebook
  end
end
      
class Image < Shareable
  def share_on_facebook
  end
end
      
class Tweet < Shareable
  def share_on_facebook
  end
end

# вместо этого класса-родителя, лучше использовать миксин - mixin и делаее иклюдить в нужный нам класс
module Shareable
  def share_on_facebook
  end
end 

module Favoritable
  def add_to_delicious
  end
end    
      
class Post
  include Shareable
end

class Image
  include Shareable
end

class Tweet
  include Shareable
  include Favoritable
end
      
#------------Подключение к классовым методам
# также возможно подключать модули к классовым методам с помощью extend

class Tweet
  extend Searchable
end

module Searchable
  def find_all_from(user)
  end
end

# теперь можно вызвать метод find_all_from, как классовый, т.е. без создания объекта
Tweet.find_all_from('@GreggPollack')

#------------HOOKS - SELF.INCLUDED
# в случае, если нам нужно вызавать методы класса модуля (классовые методы) и методы самого модуля (инстансные методы), то можно использовать такой вариант:

module ImageUtils
  def preview
  end
  
  def transfer(destination)
  end
  
  module ClassMethods
    def fetch_from_twitter(user)
    end
  end
end
      

class Image
  include ImageUtils # - подключаем модуль ImageUtils
  extend ImageUtils::ClassMethods # - подключаем модуль ClassMethods
end

# и теперь мы можем обращаться к инстансным методам через объект
image = user.image
image.preview
# а также, как к классовым методам
Image.fetch_from_twitter('gregg')

# Но лучше использовать специальный метод в модуле, который позволит нам подключать инстансные и классовые методы вместе

module ImageUtils
  # здесь мы подключаем инстансные методы
  # метод included подкючает классовые методы к классу, к которому будет подключен модуль 
  def self.included(base)
    base.extend(ClassMethods)
  end
  
  def preview
  end
  
  def transfer(destination)
  end
  
  module ClassMethods
  #  в модуле ClassMethods, классовые методы самого модуля, которые должны вызавать ВНЕ объекта
    def fetch_from_twitter(user)
    end
  end
end

# теперь подключаем наш модуль к классу Image
class Image
  include ImageUtils
end

# И теперь мы можем использовать методы модуля внутри подключенного класса
image = user.image
image.preview # инстансные методы
Image.fetch_from_twitter('gregg') # классовые методы
      
# ---------------ACTIVESUPPORT::CONCERN
# с помощью модуля ACTIVESUPPORT::CONCERN мы можем подключать к классу, методы из разнах модулей, а также группировать модули по функциональности.

# есть модуль управления изображениями
module ImageUtils
# подключаем к нему библиотеку Concern
  extend ActiveSupport::Concern
# далее создаем модуль для хранения классовых методов
  module ClassMethods
    def clean_up; end
  end
end

# далее создаём ещё один моуль для управления изображением
module ImageProcessing
  extend ActiveSupport::Concern
  # подключаем к нему функционал модуля ImageUtils
  include ImageUtils
  # в спецаильном блоке указываем какие классовые методы, мы хотим подключить к модулю
  included do
    clean_up
  end
end

# теперь нам достаточно подключить к классу только один модуль ImageProcessing и к нему будет подключен весь функционал методов от модуля ImageUtils и от других возможно подключенных модулей
class Image
  include ImageProcessing
end

#--- Пример, как можно добавлять классовые методы, как инстансные, с помощью библиотеки Concern и блока included:
# Как мы видим, внизу, внутри модуля LibraryUtils мы подключаем саму библиотеку ActiveSupport::Concern, а также добавляем блок included, с указанием классовых методов, которые мы хотим вызывать "инстансно".
# После этого, мы можем вызывать эти методы, как инстансные.
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

#========================= BLOCKS ==========================
#--- USING BLOCKS ---------------
# так писать блоки не нужно
words = ['Had', 'eggs', 'for', 'breakfast.']
for index in 0..(words.length - 1)
  puts words[index]
end

# блоки нужно писать ТАК
words = ['Had', 'eggs', 'for', 'breakfast.']
words.each { |word| puts word }

#--- DECLARING BLOCKS ---------------
# в случае еси код блока помещается в одну строку, то мы используем фигурные скобки {}
words.each { |word| puts word }
# если же код блока не помещается в одну строку, то мы используем ключевые слова do end
words.each do |word|
  backward_word = word.reverse
  puts backward_word
end

# если нам нужно вернуть занчение из одной операции, как здесь
words.each do |word|
  puts word
end
# то лучше такой код указывать в одной строке через {}
backward_words = words.map { |word| word.reverse }

#--------------YIELD--------------------
# yield - используются когда нам нужно указать конкретное место в блоке, где мы хотим его использовать, например:
  
def call_this_block_twice
  yield
  yield
end
  
# здесь мы видим, что слово yield используется дважды, и значит, что аргумент передаваемый в блоке будет выполняться дважды, как здесь

call_this_block_twice { puts "twitter" } #=> twitter twitter
call_this_block_twice { puts "tweet" } #=> tweet tweet
  
#--------------YIELD - ARGUMENTS--------------------
# для yield можно указать аргумент и тогда будет выполняться именно то значение, которое будет указано в аргументе





