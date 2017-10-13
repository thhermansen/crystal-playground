require "option_parser"

module Playground
  class Main
    enum ProgramChoice
      NotSet

      HttpServer
      Rant
    end

    abstract class ProgramRunner
      abstract def call(program : ProgramChoice)
    end

    @program = nil
    @program_names = [] of String

    def initialize(
      args : Array(String),
      program_runner : ProgramRunner,
      stdout : IO = STDOUT
    )
      @args = args
      @stdout = stdout
      @program_runner = program_runner
      @program = ProgramChoice::NotSet
      @program_names = ProgramChoice.names[1..-1] # Don't want to expose the first one
    end

    def run
      create_parser_and_parse_options
      print_help_if_no_program_selected
      run_selected_program
    end

    private def create_parser_and_parse_options
      @parser = OptionParser.parse(@args) do |parser|
        parser.banner = "Usage: playground [arguments]"

        parser.on "-p", "--program=NAME", "One of: #{@program_names}" do |name|
          @program = ProgramChoice.parse? name
        end

        parser.on "-h", "--help", "Show this help" do
          puts parser
          help_printed = true
        end
      end
    end

    private def print_help_if_no_program_selected
      return unless @program == ProgramChoice::NotSet

      puts @parser
    end

    private def run_selected_program
      if @program.nil?
        puts "You selected a program we do not have. Please try again, one of: #{@program_names}"
        puts "\n\n#{@parser}"
      else
        @program_runner.call @program
      end
    end

    private def puts(*args)
      @stdout.puts *args
    end
  end
end
