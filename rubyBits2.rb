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
# self вызванная вне класса, возвращает объект main
puts "Outside the class: #{self}" # => mail
# self вызванная вне класса, возвращает объект класса в котором он был вызван
class Tweet
  puts "Inside the class: #{self}"
end

#--------------------- CLASS METHODS ----------------------------
# классовые (внешние) методы, методы, которые вызываются вне объекта 
class Tweet
  def self.find(keyword)
    puts "Inside a class method: #{self}"
  end
end
# выхов классового метода, осуществляется вне объекта, через сам класс
Tweet.find("rubybits")
# традиционное объявление классового метода:
class Tweet
  def self.find(keyword)
    # do stuff here
  end
end
# ещё один способ объявить классовый метод, который используют реже
def Tweet.find(keyword)
  # do stuff here
end

# простой пример инстансного (внутреннего) метода
class Tweet
  def initialize(status)
    puts "Inside a method: #{self}"
    @status = status
  end
end

Tweet.new("What is self, anyway?")

#----------------- CLASS_EVAL -----------------------------
# CLASS_EVAL - устанавливаем self-свойства в заданый класс, рассмотрим примеры
class Tweet
  attr_accessor :status, :created_at

  def initialize(status)
    @status = status
    @created_at = Time.now
  end
end

Tweet.class_eval do
  attr_accessor :user
end

tweet = Tweet.new("Learning class_eval with Ruby Bits")
tweet.user = "codeschool"
# таким образом мы можем динамически добавлять в класс аксессоры или классовые методы, когда захотим 

#----------------- CREATING A METHOD LOGGER -----------------------------
#Рассмотри прменение динамических инструментов работы с классами, на приере  создания метода-логгера. Данный метод будет принимать в себя аргумент имя класса и имя метода, который будет исполнятся. Далее метод будет создавать оригинальную копию исполняемого метода и фиксировать время последнего исполнения. 

class MethodLogger
  # в аргументах метода, мы передаем имя класса, которое будем использовать,  и имя метода
  def log_method(klass, method_name)
    # далее мы с помощью класса class_eval, добавляем в класс нужный нам метод, который будем исполнять. В переменной klass передается имя класса, ну а в переменной method_name, соответственно имя классового метода, который будем исполнять.
    klass.class_eval do
      # создаем копию метода, который будем исполнять, добавляем к имени метода окончание - "_original"
      alias_method "#{method_name}_original", method_name
      # далее мы переопределеяем выбранный метод с помощью блока define_method:
      define_method method_name do
        # здесь заносим дату и время последнего исполнения метода
        puts "#{Time.now}: Called #{method_name}"
        # здесь вызываем оригинальную версию исполяемого метода метода
        send "#{method_name}_original"
      end
    end
  end
end

# таким образом мы получили версию метода-логгера, который фиксирует время исполнения определенного метода, заданного ему в аргументе.
# рассмотрим пример изполнение метода-логгера
# описание класса
class Tweet
  def say_hi
    puts "Hi"
  end
end

# создание объекта класса
logger = MethodLogger.new
# передаем в метод имя класса и имя метода для логгирования
logger.log_method(Tweet, :say_hi)

Tweet.new.say_hi #=> 2012-09-01 12:52:03 -400: Called say_hi - Hi

# но вышеуказанный метод не учитываем принимаемые аргументы и блоки в исполняемый (логированный) метод, зададим аргументы и блоки исполняемому методу:
class MethodLogger
  def log_method(klass, method_name)
    klass.class_eval do
      alias_method "#{method_name}_original", method_name
      # здесь мы передаём аргументы и блоки
      define_method method_name do |*args, &block|
        puts "#{Time.now}: Called #{method_name}"
        # здесь мы исполняем оригинальный метод с аргументами и блоками
        send "#{method_name}_original" , *args, &block
      end
    end
  end
end

#----------------- INSTANCE_EVAL -----------------------------
# с помощью блока .instance_eval мы можем передавать инстансные переменные класса. Рассмотрим пример клссса с аксессором для объявления инстансный переменных:

class Tweet
  attr_accessor :user, :status
end

# далее мы с помощью метода .instance_eval задаем параметры переменной status
tweet = Tweet.new
tweet.instance_eval do
  self.status = "Changing the tweet's status"
end

# рассмотрим пример задания инстансный переменных класса через блок
class Tweet
  attr_accessor :user, :status
  
  def initialize
  # здесь yield имеет значение по-умолчанию - self, для того чтоб объявить именно инстансные методы.
    yield self if block_given?
  end
end

# объявляем блок с указанием инстансных переменных:
Tweet.new do |tweet| # здесь в значении tweet передается значение по-умолчанию для блока - self, поэтому код  tweet.status соответствует коду self.status
  tweet.status = "I was set in the initialize block!"
  tweet.user = "Gregg"
end

# но вышеуказанный код можно описать с помощью блока instance_eval, рассмотрим пример:

class Tweet
  attr_accessor :user, :status
  # передаем блок на исполнение в аргументе на инициализацию
  def initialize (&block)
  # далее с помощью блока instance_eval мы указываем, что весь код переданные в блоке-аргументе, должен передавать значения инстансным переменным
    instance_eval(&block) if block_given?
  end
end

# и далее мы просто создаем блок, который будем передавать классу, только здесь уже вместо |tweet| прямо так и указываем - self
Tweet.new do
  self.status = "I was set in the initialize block!"
  self.user = "Gregg"
end

# таким образом мы получили более "чистый" код.

#========================= LEVEL 4: HANDLING MISSING METHODS ==================
#----------------- METHOD_MISSING -----------------------------
# с помощью метода method_missing() мы можем указать выполнение объекту в случае вызова неизвестного метода.

class Tweet
  # здесь в аргументе мы передаем имя метода, и аргументы
  def method_missing(method_name, *args)
    # здесь передаем нужный нам текст ошибки, исполнение может быть любое
    puts "You tried to call #{method_name} with these arguments: #{args}"
  end
end

Tweet.new.submit(1, "Here's a tweet.")
#=> You tried to call submit with arguments: [1, "Here's a tweet."]

# ещё один пример использование с логированием результата вызова


class Tweet
  def method_missing(method_name, *args)
    # логируем результат вызова метода
    logger.warn "You tried to call #{method_name} with these arguments: #{args}"
    # исполняем оригинальный метод - method_missing - NoMethodError
    super
  end
end

#----------------- DELEGATING METHODS -----------------------------
# теперь представим ситуация, когда нам нужно вызывать какие-то методы объекта, который передается нам в аргументе класса

class Tweet
  def initialize(user)
    @user = user
  end

  def username
    @user.username
  end

  def avatar
    @user.avatar
  end
end

# в примере выше, мы видим, что в аргемунте передается объект user, и мы вызываем его метода username и avatar.
# Но это может быть неудобно, создавать отдельный метод для каждого метода объекта переданного в аргументе
# как альтернативу, можно использовать динамический ваызов методов .send

class Tweet
  def initialize(user)
    @user = user
  end

  def method_missing(method_name, *args)
  # выхываем методы класса динамически с помощью метода .send
    @user.send(method_name, *args)
  end
end

# но даже такой способ может быть не подходящим, т.к. в примере выше, можно вызвать любой метод объекта @user, а что если нам нужно чтоб доступ был только к определенным методам? Тогда можно использовать список делегированых методов - DELEGATED_METHODS

class Tweet
  # здесь в массиве, мы указываем имена доступных методов, через символы.
  # таким образом мы формируем список делегируемых методов
  DELEGATED_METHODS = [:username, :avatar]

  def initialize(user)
    @user = user
  end

  # объявляем исполнение метода - method_missing
  def method_missing(method_name, *args)
    # с помощью метода DELEGATED_METHODS.include?, мы определеяем, есть ли в списке делегированных методов, объявленный
    if DELEGATED_METHODS.include?(method_name)
      # далее, если метод найден среди делегируемых, мы вызываем его с помощью .send
      @user.send(method_name, *args)
    else
      # если такого метода нет, мы переходим к стандартному исполнению method_missing
      super
    end
  end
end

#----------------- SIMPLE DELEGATOR -----------------------------
# с помощью класса SimpleDelegator, мы можем автоматически делегировать все методы указанные в заданном объекте

require 'delegate'

class Tweet < SimpleDelegator
# все методы объекта user, будут делегированы классу tweet
  def initialize(user)
    super(user)
  end
end

#----------------- DYNAMIC METHODS -----------------------------
# динамические методы можно использовать, когда нам известно часть имени методов, некая маска у определенной группы методов, и мы можем вызывать такие методы, с помощью заджачи параметров этой маски

# есть обычный класс
tweet = Tweet.new("Sponsored by")
# у класса есть группа методов, название которых, начинается с hash_*
tweet.hash_ruby
tweet.hash_metaprogramming
puts tweet

# мы можем вызыввать любой метод из этой группы, с помощью такого кода:

class Tweet
  def initialize(text)
    @text = text
  end

  def to_s 
    @text
  end

  def method_missing(method_name, *args)
    # далее мы с вносим данные в переменную match, если данные соответствуют нашей маски, т.е. мы применяем маску и вставляем фрагмент "hash_" перед именем каждого метода.
    match = method_name.to_s.match(/^hash_(\w+)/)
    if match
      @text << " #" + match[1]
    else
      super
    end
  end
end

#----------------- RESPOND_TO? -----------------------------
# с помощью метода RESPOND_TO?, мы можем проверять наличие определенного метода в классе, пример

tweet = Tweet.new
tweet.respond_to?(:to_s)      # => true
tweet.hash_ruby   # этот метод будет работать, потому что мы объявили метод method_missing
tweet.respond_to?(:hash_ruby) # => false, но результат false в этом случае не будет правильным, т.к. метод объявлен в method_missing
# для того, чтоб исправить эту ситуацию, нужно переопределить метод respond_to?, для класса Tweet:

class Tweet
...
  def respond_to?(method_name)
    # вносим в переопределение метода условие, по которому, к имени вызываемого метода, добавляется наша маска, и только в случае, если метод с маской не найден, выполняются действия по-умолчанию.
    method_name =~ /^hash_\w+/ || super
  end
end

# в таком случае метод .respond_to? вернет true:
tweet.respond_to?(:hash_ruby) # => true

#----------------- RESPOND_TO_MISSING? -----------------------------
# но остается ещё одна проблемка, в случае приминения метода .method, занесение исполнения метода в отдельную переменную, и дальнейшее применение аналогично блоку, будет не возможным, т.к. вернет ошибку
tweet.method(:hash_ruby) # => NameError: undefined method

# решение это ситуации доступно с версии Ruby 1.9.3, с помощью переопределения метода respond_to _missing ?

class Tweet
...
  def respond_to _missing ?(method_name)
    method_name =~ /^hash_\w+/ || super
  end
end

tweet = Tweet.new
tweet.method(:hash_ruby) # в этом случае будет возвращен метод .hash_ruby

#----------------- DEFINE_METHOD REVISITED -----------------------------
# также рассмотрим ситуацию, когда динамически формируемый метод вызывается два раза подрдяд:

def method_missing(method_name, *args)
  match = method_name.to_s.match(/^hash_(\w+)/)
  if match
    @text << " #" + match[1]
  else
    super
  end
end

tweet.hash_codeschool
tweet.hash_codeschool
# в этом случае, мы получим динамическое формирование метода дважды. В вызов может быть и более двух раз подряд, все это может быть очень накладно по ресурсам, что будет влиять на производительность.
# для ускорение работы кода, в этом случае, нам нужно, при первом динамическом формировании метода, "запомнить" его, путем динамического создания в классе, и в дальнейшем, при повторном вызове, обращаться уже непосредственно к этому созданному методу, а не создавать его постоянно динамически снова.
# реализуется такой подход следующим способом:

def method_missing(method_name, *args)
  match = method_name.to_s.match(/^hash_(\w+)/)
  if match
    # получаем доступ ко внутреннему классу, через блок .class_eval
    self.class.class_eval do
      # далее динамически создаем метод с нужным для нас именем с помощью блока define_method
      define_method(method_name) do
        # исполнение метода идет с блоке define_method
        @text << " #" + match[1]
      end
    end
    # далее мы просто вызываем этот метод
    send(method_name)
  else
    super
  end
end

tweet.hash_codeschool # => сначала будет исполнен method_missing
tweet.hash_codeschool # => а тут уже будет исполнен непосредственно .hash_codeschool















