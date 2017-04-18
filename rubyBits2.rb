#========================= BLOCKS, PROCS, AND LAMBDAS ======================
# проки и лямбды, позволяют сохранить реализацию конкретного блока и занести её в переменную, как объект. Таким образом мы сможем вызвать исполнение блока в любой удобный для нас момент, с помощью метода .call
#---------- TWO WAYS 4 STORING BLOCKS ----------------------------

# Создание прока - Proc.new
my_proc = Proc.new { puts "tweet" }
my_proc.call # => tweet

# Создание лямпды  - lambda
my_proc = lambda { puts "tweet" }
my_proc.call # => tweet

# Создание лямпды, начиная с версии ruby 1.9  ->
my_proc = -> { puts "tweet" }
my_proc.call # => tweet

# вызов блоков
my_proc = Proc.new do
  puts "tweet"
end
my_proc.call # => tweet

#---------- BLOCK TO LAMBDA ----------------------------
# пример вызова блока. Вот класс с блоком внутри
class Tweet
  def post
    if authenticate?(@user, @password)
      # указываем где будем исполнять блок
      yield
    else
      raise 'Auth Error'
    end
  end
end

# вот так мы будем пользоваться этим блоком
tweet = Tweet.new('Ruby Bits!')
tweet.post { puts "Sent!" }

# Теперь рассмотрим тот же пример но с использованием лямпды
class Tweet
  # здесь в метод post мы передаем аргумент с лямпдой
  def post(success)
    if authenticate?(@user, @password)
      # здесь мы эту лямпду вызываем
      success.call
    else
      raise 'Auth Error'
    end
  end
end

# И вот таким образом мы это лямпдой пользуемся
tweet = Tweet.new('Ruby Bits!')
# здесь создаём лямпду
success = -> { puts "Sent!" }
# передаём ей аргумент в объект, где она вызывается
tweet.post(success)

#---------- MULTIPLE LAMBDAS ----------------------------
# мульти-лямды, можно использовать для исполнения определенных участков кода в определенных полях, рассмотрим пример

class Tweet
  # здесь, в аргументе мы уже указываем две лямды, 
  def post(success, error)
    if authenticate?(@user, @password)
      # Здесь мы вызываем лямду если все удачно
      success.call
    else
      # А здесь - если все НЕ удачно
      error.call
    end
  end
end

# здесь мы описываем лямды и добавляем их в метод
tweet = Tweet.new('Ruby Bits!')
success = -> { puts "Sent!" }
error = -> { raise 'Auth Error' }
tweet.post(success , error)

#---------- LAMBDA TO BLOCK ----------------------------
# мы можем использовать лямпду, как аргумент исполнения в блоках, рассмотри пример
# есть массив, и мы поочередно выводим его содержимое через цикл .each. 
tweets = ["First tweet", "Second tweet"]
tweets.each do |tweet|
  puts tweet
end

# Здесь цикл рассматривается, как блок, в который мы можем передать лямду, как аргумент
tweets = ["First tweet", "Second tweet"]
# Создаём лямду
printer = lambda { |tweet| puts tweet }
# передаём лямду, как аргумент с добавлением &
tweets.each (&printer)

#---------- PASSING BLOCKS THROUGH ----------------------------
# аргемунт лямды можно также "пропустить" через блок, если нам нужно выполнить его во вложенном блоке, рассмотрим пример:
# этот код выдаст ошибку, потому что в аргументе блока передается лямда без символа &

class Timeline
  attr_accessor :tweets
  def each
    # вот здесь в исполнение блока передается другой блок, поэтому будет ошибка
    tweets.each { |tweet| yield tweet }
  end
end

# для того, чтоб нам передать этот блок нужно "пропустить" его через аргументы метода и самого вызываемого блока .each

class Timeline
  attr_accessor :tweets
  # здесь мы передаем блок в аргументе метода 
  def each(&block)
  # и также передаем блок в аргументе блока .each
    tweets.each(&block)
  end
end

# и теперь для вызова блока мы можем передать лямду
timeline = Timeline.new(tweets)
lam = lambda { puts tweet }
timeline.each(&lam)
#---------- SYMBOL#TO_PROC ----------------------------
# также проки можно использовать в качестве готовых функкий, представим себе пример
tweets.map { |tweet| tweet.user }
# здесь мы видим, что к каждому элементу массива tweets применяется метод user, вместо вышеуказанной записи можно использовать её короткий вариант
tweets.map(&:user)
# здесь мы также применяем метод user к каждому элементу массива, но имя метода, указываем через амперсанд и как символ - &:user
# а вот так писать не нужно:
tweets.map(&:user.name) #=> undefined method `name' for :user:Symbol (NoMethodError)
#---------- OPTIONAL BLOCKS ----------------------------
# опциональные блоки, можно использовать только в том случае, когда блок передается как аргумент метода, рассмотрим пример метода print, который имеет исполнение как блока, так и обычное процедурное:

class Timeline
  attr_accessor :tweets
  def print
    # это условие будет исполнено, если будет блочный вызов
    if block_given?
      tweets.each { |tweet| puts yield tweet }
    # это, если обычный процедурный вызов
    else
      puts tweets.join(", ")
    end
  end
end
# пример использования
timeline = Timeline.new # создаём объект класса
timeline.tweets = ["One", "Two"] # вносим массив
# процедурный вызов метода
timeline.print # => One, Two
# выхов через блок, здесь аргумент будет подставлен вместо yield
timeline.print { |tweet|
"tweet: #{tweet}"
}

#---------- CLOSURE ----------------------------
# также блок можно использовать как составляющую метода, пример
def tweet_as(user)
  lambda { |tweet| puts "#{user}: #{tweet}" }
end
# здесь мы видим метод создает лямду с аргументом user
gregg_tweet = tweet_as("greggpollack")
# создали блок, верняя строка соответствует - 
# lambda { |tweet| puts "greggpollack: #{tweet}" }
# далее мы мы применяем лямду через мето
gregg_tweet.call("Mind blowing!")
# здесь значение "Mind blowing!" подставляется, как аргумент лямды - tweet

#========================= DYNAMIC CLASSES & METHODS ======================
#--------------- STRUCT--------------------
# структуру можно рассматривать как динамический класс, рассмотрим пример
class Tweet
  attr_accessor :user, :status
  def initialize(user, status)
    @user, @status = user, status
  end
end
# вызов класса
tweet = Tweet.new('Gregg', 'compiling!')
tweet.user # => Gregg
tweet.status # => compiling!

# вместо вышеуказанного кода, можно использовать структуры
Tweet = Struct.new(:user, :status)
# здесь структура заменяем вышеуказанный класс, имеет теже поля.

#--------------- STRUCT EXTRA METHODS --------------------
# также структуры могут иметь сви методы
# вот пример класса с методом to_s
class Tweet
  attr_accessor :user, :status

  def initialize(user, status)
    @user, @status = user, status
  end

  def to_s
    "#{user}: #{status}"
  end
end

# а вот пример структуры с тем же методом to_s, описаный в блоке между do-end
Tweet = Struct.new(:user, :status) do
  def to_s
    "#{user}: #{status}"
  end
end

#--------------- ALIAS_METHOD --------------------
# алиас методы, позволяют нам создать точную копию какого-то метода, со своим именем, псевдонимом, и при необходимости мы можем также менять созданную копию, и потом обращаться к ней по этому псевдониму.
# пример класса с дублирующими методами tweets и contents

class Timeline
  def initialize(tweets = [])
    @tweets = tweets
  end
  def tweets
    @tweets
  end
  def contents
    @tweets
  end
end

# теперь мы просто можем заменить класс на алиас-методы
class Timeline
  def initialize(tweets = [])
    @tweets = tweets
  end
  def tweets
    @tweets
  end
  # здесь мы создаём копию метода tweets по имени contents
  alias_method :contents, :tweets
end

# по сути метод tweets является attr_reader, и мы можем также скопировать его:
class Timeline
  def initialize(tweets = [])
    @tweets = tweets
  end
    attr_reader :tweets
    alias_method :contents, :tweets
end

# использование старой копии метода
# у нас есть класс
class Timeline
  attr_accessor :tweets

  def print
    puts tweets.join("\n")
  end
end

# сейчас мы переобъявим этот класс с новым алиас-методом old_print
class Timeline
  # здесь мы создаем копию print с новым названием old_print
  alias_method :old_print, :print

  # здесь мы переобъявляем метод print, при этом старый метод храниться под именем - old_print
  def print
    authenticate!
    # здесь мы применяем наше старое исполнение print
    old_print
  end

  def authenticate!
    # здесь исполяется какой-нибудь метод
  end
end

# но вместо вышеуказанного кода, понятнее будет использовать наследование класса:
class Timeline # пример того же класса Timeline
  attr_accessor :tweets
  def print
    puts tweets.join("\n")
  end
end

# и здесь, вместо алиас-метода лучше использовать наследование - 
class AuthenticatedTimeline < Timeline
  def print
    authenticate!
    # и здесь мы просто добавляем старое исполнение метода
    super
  end

  def authenticate!
    # do some authentication here
  end
end

#--------------- DEFINE_METHOD --------------------
# рассмотрим пример класса
class Tweet
  def draft
    @status = :draft
  end
  def posted
    @status = :posted
  end
  def deleted
    @status = :deleted
  end
end

# с помощью блока define_method, мы можем создавать методы динамически,
class Tweet
  # здесь мы зараннее создаём массив с именами методов и значениями переменной @status
  states = [:draft, :posted, :deleted]
  # далее мы, с помощью блока define_method, перебираем раннее созданный массив и создаём динамический метод для каждого его элемента, с описанием этого метода внутри блока define_method
  states.each do |status|
    define_method status do
      @status = status
    end
  end
end

#--------------- SEND --------------------
# с помощью метода send, мы можем динамически вызывать методы класса, рассмотрим пример класса:
class Timeline
  def initialize(tweets)
    @tweets = tweets
  end
  
  def contents
    @tweets
  end

  private

    def direct_messages
  end
end

# далее мы создаем объект класса и передаем в него базовый массив @tweets
tweets = ['Compiling!', 'Bundling...']
timeline = Timeline.new(tweets)

# далее мы можем вызвать метод класса 
timeline.contents
# но такой способ не подходит, если нам нужно вызывать методы динамически, т.е. когда мы не знаем зараннее какой метод хотим вызвать. Здесь мы можем реализовать такой вызов, с помощью метода .send
timeline.send(:contents)
# в аргументе метода, мы передаем имя вызываемого метода внутри класса
timeline.send("contents")
# в аргументе может быть указано любое значение метода, как строка, так и символ
timeline.send(:direct_messages)
# также метод имеет доступ ко всем областям видимости - private, protected

# также начиная с версии 1.9.2, мы можем вызывать динамически, только публичные методы
timeline.public_send(:direct_messages) #=> private method `direct_messages' called for #<Timeline:0x007fd273904eb0> (NoMethodError)
# вышеуказанная строка выдаст ошибку, потому что мы обращаемся к приватному методу

#--------------- THE METHOD METHOD --------------------
# также мы можем динамический результат вызова метода, поместить в переменную, и вызывать её, как блок. Рассмотрим применение на примере вышеуказанного класса Timeline
content_method = timeline.method(:contents)
# здесь вызов динамического метода contents, присваивается переменной content_method (которая в последствии становится блоком), с помощью метода .method => #<Method: Timeline#contents>
content_method.call
# и далее мы вызываем метод, как блок => ["Compiling!", "Bundling..."]
# аналогично вызываем метод show_tweet(index)
show_method = timeline.method(:show_tweet) 
# => #<Method: Timeline#show_tweet>
show_method.call(0)
# здесь вызов метода проходит с указанием аргумента

# Также мы можем исполнять вышеуказанным метод show_tweet, в цикле с разными аргументами, короткая запись такого кода выглядет так:
(0..1).each(&show_method)
# строка выше, соответствует строке ниже:
show_method.call(0)
show_method.call(1)


#========================= LEVEL 3: UNDERSTANDING SELF ==================





