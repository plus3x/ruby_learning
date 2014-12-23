module Console
  class ColorString < String
    def black()         "\033[30m#{self}\033[0m" end
    def red()           "\033[31m#{self}\033[0m" end
    def green()         "\033[32m#{self}\033[0m" end
    def brown()         "\033[33m#{self}\033[0m" end
    def blue()          "\033[34m#{self}\033[0m" end
    def magenta()       "\033[35m#{self}\033[0m" end
    def cyan()          "\033[36m#{self}\033[0m" end
    def gray()          "\033[37m#{self}\033[0m" end
    def bg_black()      "\033[40m#{self}\033[0m" end
    def bg_red()        "\033[41m#{self}\033[0m" end
    def bg_green()      "\033[42m#{self}\033[0m" end
    def bg_brown()      "\033[43m#{self}\033[0m" end
    def bg_blue()       "\033[44m#{self}\033[0m" end
    def bg_magenta()    "\033[45m#{self}\033[0m" end
    def bg_cyan()       "\033[46m#{self}\033[0m" end
    def bg_gray()       "\033[47m#{self}\033[0m" end
    def bold()          "\033[1m#{self}\033[22m" end
    def reverse_color() "\033[7m#{self}\033[27m" end
  end

  class << self
    def log(text = nil, dir: nil, color: nil)
      text = ColorString.new text
      text = text ? " #{text} " : ''

      case
      when block_given?
        comment text, prefix: :begin, color: color || :blue

        yield

        comment text, prefix: :end, color: color || :blue
      when dir == :begin
        comment text, prefix: :begin, color: color || :yellow
      when dir == :end
        comment text, prefix: :end, color: color || :yellow
      else
        comment text, color: color || :green
      end
    end

    private

    def comment(text, prefix: nil, color: :black)
      prefix = prefix ? " #{prefix.to_s.upcase}" : ''

      puts "#{prefix} #{text}".center(80, '=').send(color)
    end
  end
end
