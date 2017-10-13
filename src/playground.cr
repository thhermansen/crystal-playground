require "option_parser"
require "./playground/*"


module Playground
  class Main
    enum ProgramChoice
      NotSet

      HttpServer
      Rant
    end

    @program = nil
    @program_names = [] of String

    def initialize
      @program = ProgramChoice::NotSet
      @program_names = ProgramChoice.names[1..-1] # Don't want to expose the first one
    end

    def run
      parse_options
      print_help_and_exit_if_no_program_selected
      run_selected_program
    end

    private def parse_options
      @parser = OptionParser.parse! do |parser|
        parser.banner = "Usage: playground [arguments]"

        parser.on "-p", "--program=NAME", "One of: #{@program_names}" do |name|
          @program = ProgramChoice.parse? name
        end

        parser.on "-h", "--help", "Show this help" do
          help_printed = true ; puts parser
        end
      end
    end

    private def print_help_and_exit_if_no_program_selected
      return unless @program == ProgramChoice::NotSet

      puts @parser
      exit 0
    end

    private def run_selected_program
      case @program
      when ProgramChoice::HttpServer
        puts "Not yet implemented"
      when ProgramChoice::Rant
        Rant::Main.new.call
      else
        puts "You selected a program we do not have. Please try again, one of: #{@program_names}"
        puts "\n\n#{@parser}"
      end
    end
  end

  Main.new.run
end
