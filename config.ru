# frozen_string_literal: true

require 'rack'
require 'rack/response'
require 'redis'

# run docker-compose up

class Application
  def call(_env)
    response = Rack::Response.new
    redis = Redis.new(host: 'redis', port: 6379)
    current = redis.get('a').to_i
    current += 1
    redis.set('a', current)

    response.write "This is Rack #{current}"
    response.write '!!!'
    response['Content-Type'] = 'text/html'
    response.finish
  end
end

Rack::Handler.default.run(Application.new, Port: 5000)
