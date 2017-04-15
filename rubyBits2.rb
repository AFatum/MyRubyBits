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
lam = -> {puts tweet}
timeline.each(&lam)