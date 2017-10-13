module Playground::Rant
  # A ranter is something which rants out random quotes through given channel
  class Ranter
    def initialize(@name : String, @channel : Channel(Rant), @quotes : Quotes, @times = 10)
    end

    def start_ranting

    end
  end
end
