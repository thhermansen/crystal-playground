module Playground::Rant
  struct Rant
    property ranter : Ranter, quote : String

    def initialize(@ranter, @quote)
    end
  end
end
