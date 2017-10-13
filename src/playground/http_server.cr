require "http/server"

module Playground
  module HttpServer
    extend self
    
    class SleepyRequestHandler
      include HTTP::Handler
      
      class ClientError < Exception; end
      
      UNPROCESSABLE_ENTITY = 422
      
      def initialize(@fiber = Fiber)
      end
      
      def call(context)
        t1 = Time.now
        context.response.content_type = "text/plain"
        @fiber.sleep requested_sleep_time_ms(context.request) / 1000
        t2 = Time.now
        context.response.print "I'm done! Started at: #{t1}, ended at #{t2}"
      rescue err : ClientError
        context.response.respond_with_error err, UNPROCESSABLE_ENTITY
      end
      
      private def requested_sleep_time_ms(request)
        request.resource.lchop('/').to_i
      rescue ArgumentError
        raise ClientError.new "Path must simply by an integer, ms to sleep"
      end
    end
    
    def listen
      handlers = [
        HTTP::ErrorHandler.new,
        HTTP::LogHandler.new,
        SleepyRequestHandler.new
      ]
      
      Logger.instance.info "Listening on http://127.0.0.1:8080"
      server = HTTP::Server.new(8080, handlers).listen
    end
  end
end