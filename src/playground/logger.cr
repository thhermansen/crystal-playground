require "logger"

module Playground
  class Logger < ::Logger
    def self.instance
      @@logger ||= new STDOUT
    end
  end
end
