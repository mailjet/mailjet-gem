require 'rack/request'
require 'yajl/json_gem'

module Mailjet
  module Rack
    class Endpoint
      def initialize(app, path, &block)
        @app = app
        @path = path
        @block = block
      end

      def call(env)
        if env['PATH_INFO'] == @path && (content = env['rack.input'].read)
          @block.call(JSON.parse(content))
          [200, { 'Content-Type' => 'text/html', 'Content-Length' => '0' }, []]
        else
          @app.call(env)
        end
      end
    end
  end
end
