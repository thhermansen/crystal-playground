require "../spec_helper"
require "../../src/playground/main"

private class TestProgramRunner < Playground::Main::ProgramRunner
  getter program

  def call(@program : Playground::Main::ProgramChoice | Nil)
  end
end

describe "Playground" do
  describe "Main" do
    it "prints help when no option given" do
      io = IO::Memory.new
      Playground::Main.new([] of String, TestProgramRunner.new, io).run
      io.to_s.starts_with?("Usage: playground [arguments]").should be_true
    end

    it "prints help when wrong program name is used" do
      io = IO::Memory.new
      Playground::Main.new(["-p", "foo"] of String, TestProgramRunner.new, io).run
      msg = %(You selected a program we do not have. Please try again, one of: ["HttpServer", "Rant"])
      io.to_s.starts_with?(msg).should be_true
    end

    it "passes the program of choice off to the runner" do
      runner = TestProgramRunner.new
      Playground::Main.new(["-p", "HttpServer"] of String, runner, IO::Memory.new).run
      runner.program.should eq Playground::Main::ProgramChoice::HttpServer
    end
  end
end
