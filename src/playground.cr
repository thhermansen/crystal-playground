require "./playground/*"

module Playground
  class ProgramRunner < Main::ProgramRunner
    def call(program)
      case program
      when Main::ProgramChoice::HttpServer
        HttpServer.listen
      when Main::ProgramChoice::Rant
        Rant::Main.new.call
      else
        raise "Unsupported program #{program}"
      end
    end
  end

  Main.new(ARGV, ProgramRunner.new).run
end
