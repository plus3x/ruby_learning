# http://www.ruby-doc.org/core-2.1.5/Exception.html
module TestExceptions
  module_function

  EXCEPTIONS = [
    SyntaxError,
    SignalException,
    Interrupt,
    LoadError,
    NoMemoryError,
    NotImplementedError,
    SystemExit,
    StandardError,
  ]

  def test(type)
    EXCEPTIONS.each do |exception|
      begin
        send(type, exception)
        puts format "%20s - \e[32mcatched\e[0m", exception
      rescue Exception => error
        puts format "%20s - \e[31mfaild\e[0m", error
      end
    end
  end

  def standart_error_rescue(exception)
    raise exception
  rescue StandardError
  end

  def simple_rescue(exception)
    raise exception
  rescue
  end

  def rescue_with_exception_get(exception)
    raise exception
  rescue Exception
  end

  def rescue_with_else(exception)
    raise exception
  rescue
  else
  end

  def ensure(exception)
    raise exception
  ensure
  end
end

puts '>>> Rescue with Exception test'
TestExceptions.test :rescue_with_exception_get

puts '>>> Rescue with else test'
TestExceptions.test :rescue_with_else

puts '>>> StandartError test'
TestExceptions.test :standart_error_rescue

puts '>>> Simple rescue test'
TestExceptions.test :simple_rescue

puts '>>> Ensure test'
TestExceptions.test :simple_rescue
