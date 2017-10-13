module Playground::Rant
  class Main
    @ranters = [] of Ranter

    def initialize(number_of_ranters = 2, number_of_rants_per_ranter = 10)
      init_ranters number_of_ranters, number_of_rants_per_ranter
    end

    def call
      p self
    end

    private def init_ranters(number_of_ranters, number_of_rants_per_ranter rant_times)
      number_of_ranters.times do |i|
        @ranters << Ranter.new(
          name: "Ranter ##{i + 1}",
          channel: rant_channel,
          quotes: quotes,
          times: rant_times
        )
      end

    end

    private def rant_channel
      @rant_channel = Channel(Rant).new
    end

    private def quotes
      Quotes.new
    end
  end
end
