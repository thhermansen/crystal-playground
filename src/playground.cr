require "./playground/*"

module Playground
  class ProgramRunner < Main::ProgramRunner
    def call(program)
      case program
      when Main::ProgramChoice::HttpServer
        raise "Not yet implemented"
      when Main::ProgramChoice::Rant
        Rant::Main.new.call
      else
        raise "Unsupported program #{program}"
      end
    end
  end

  Main.new(ARGV, ProgramRunner.new).run
end
