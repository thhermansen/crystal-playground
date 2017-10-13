require "option_parser"
require "./playground/*"


module Playground
  enum ProgramChoice
    NotSet

    HttpServer
    Rant
  end

  program = ProgramChoice::NotSet
  program_names = ProgramChoice.names[1..-1] # Don't want to expose the first one

  parser = OptionParser.parse! do |parser|
    parser.banner = "Usage: playground [arguments]"

    parser.on "-p", "--program=NAME", "One of: #{program_names}" do |name|
      program = ProgramChoice.parse? name
    end

    parser.on "-h", "--help", "Show this help" do
      help_printed = true ; puts parser
    end
  end

  if program == ProgramChoice::NotSet
    puts parser
    exit 0
  end

  case program
  when ProgramChoice::HttpServer
    puts "Not yet implemented"
  when ProgramChoice::Rant
    Rant::Main.new.call
  else
    puts "You selected a program we do not have. Please try again, one of: #{program_names}"
    puts "\n\n#{parser}"
  end
end
