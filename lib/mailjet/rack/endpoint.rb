require 'active_support'
require 'rack/request'


module Mailjet
  module Rack
    class Endpoint
      def initialize(app, path, &block)
        @app = app
        @path = path
        @block = block
      end

      def call(env)
        if env['PATH_INFO'] == @path && (request = ::Rack::Request.new(env)).post?
          Rails.logger.debug "request.POST == #{request.POST.inspect}"
          
          @block.call(ActiveSupport::JSON.decode(request.POST))
          [200, { 'Content-Type' => 'text/html', 'Content-Length' => '0' }, []]
        else
          @app.call(env)
        end
      end
    end
  end
end