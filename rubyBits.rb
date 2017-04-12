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
app.at_beginning_of_day   #=> вернет значение с начала дня
app.at_end_of_month       #=> вернет значение до конца месяца 
app.at_beginning_of_year  #=> вернет значение с начала года

app.advance(years: 4, month: 3, weeks: 2, days: 1)  
#=> вернет значение заданной даты плюс указанный период в аргументе

app.tomorrow #=> вернет завтрешний день, от указанной даты
app.yesterday #=> вернет вчерашний день, от указанной даты


#---------------Date----------------------------































