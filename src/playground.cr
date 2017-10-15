require "./playground/*"

module Playground
  class ProgramRunner < Main::ProgramRunner
    def call(program)
      case program
      when Main::ProgramChoice::HttpServer
        HttpServer.listen
      when Main::ProgramChoice::Rant
        Rant::Main.new.call
      when Main::ProgramChoice::Prime
        primes = Prime.new.each.first(500_000).to_a
        puts "Generated #{primes.size} primes"
      else
        raise "Unsupported program #{program}"
      end
    end
  end

  Main.new(ARGV, ProgramRunner.new).run
end
