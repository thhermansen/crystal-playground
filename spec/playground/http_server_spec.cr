require "../spec_helper"
require "../../src/playground/http_server"


module Playground::HttpServer
  describe SleepyRequestHandler do
    it "sleeps for 1.2 second when asked to" do
      io = IO::Memory.new
      request = HTTP::Request.new "GET", "/1200"
      response = HTTP::Server::Response.new io
      context = HTTP::Server::Context.new request, response

      asked_to_sleep_by = nil

      handler = SleepyRequestHandler.new ->(time : Float64) { asked_to_sleep_by = time; nil }
      handler.call context

      asked_to_sleep_by.should eq 1.2
    end

    it "returns 422 response when not being able to parse request sleep time" do
      io = IO::Memory.new
      request = HTTP::Request.new "GET", "/a10"
      response = HTTP::Server::Response.new io
      context = HTTP::Server::Context.new request, response
      handler = SleepyRequestHandler.new ->(time : Float64) { asked_to_sleep_by = time; nil }
      handler.call context

      response.status_code.should eq 422
      io.to_s.includes?("Path must simply by an integer, ms to sleep").should be_true
    end

    it "returns 422 response when time is negative" do
      io = IO::Memory.new
      request = HTTP::Request.new "GET", "/-1"
      response = HTTP::Server::Response.new io
      context = HTTP::Server::Context.new request, response
      handler = SleepyRequestHandler.new ->(time : Float64) { asked_to_sleep_by = time; nil }
      handler.call context

      response.status_code.should eq 422
      io.to_s.includes?("Path must simply by an integer, ms to sleep").should be_true
    end
  end
end
