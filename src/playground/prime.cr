module Playground
  class Prime
    include Iterator(Int32)

    def self.prime?(number)
      return false if number == 0 || number == 1
      return true if number == 2

      (2..Math.sqrt(number).to_i).each do |i|
        return false if number % i == 0
      end

      true
    end

    def initialize(start @at = 0)
    end

    def next
      found_prime = nil

      loop do
        found_prime = @at if self.class.prime? @at
        @at += 1

        return found_prime if found_prime
      end
    end
  end
end
