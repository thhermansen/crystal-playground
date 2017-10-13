require "http/server"

module Playground
  module HttpServer
    extend self
    
    class Handler
      class ClientError < Exception; end
      
      UNPROCESSABLE_ENTITY = 422
      
      def initialize(
        @request : HTTP::Request,
        @response : HTTP::Server::Response,
        @fiber = Fiber
      )
      end
      
      private getter request, response
      
      def call
        t1 = Time.now
        response.content_type = "text/plain"
        @fiber.sleep requested_sleep_time_ms / 1000
        t2 = Time.now
        response.print "I'm done! Started at: #{t1}, ended at #{t2}"
      rescue err : ClientError
        response.respond_with_error err, UNPROCESSABLE_ENTITY
      end
      
      private def requested_sleep_time_ms
        request.resource.lchop('/').to_i
      rescue ArgumentError
        raise ClientError.new "Path must simply by an integer, ms to sleep"
      end
    end
    
    def listen
      handlers = [
        HTTP::ErrorHandler.new,
        HTTP::LogHandler.new
      ]
      
      server = HTTP::Server.new(8080, handlers) do |context|
        handler = Handler.new context.request, context.response
        handler.call()
      end
      
      Logger.instance.info "Listening on http://127.0.0.1:8080"
      server.listen
    end
  end
end