require "rack/request"

class Ruter
  module Core
    # Public: It provides convenience methods for pulling out information
    # from a request.
    #
    # Examples
    #
    #   env = {
    #     "REQUEST_METHOD" => "GET"
    #     "QUERY_STRING"   => "email=me@ruter.xyz"
    #   }
    #
    #   req = Ruter::Core::Request.new(env)
    #
    #   req.get?  # => true
    #   req.post? # => false
    #
    #   req.params  # => { "email" => "me@ruter.xyz" }
    #   req[:email] # => "me@ruter.xyz"
    #
    class Request < Rack::Request
      # Public: Returns the value of the +key+ param.
      #
      # key - Any object that responds to +to_s+.
      #
      # Examples
      #
      #   req.params
      #   # => { "username" => "bob" }
      #
      #   req[:username]  # => "bob"
      #   req["username"] # => "bob"
      #
      # Signature
      #
      #   [](key)
      #
      # Inherited by Rack::Request.

      # Public: Returns a Hash of parameters. Includes data from the query
      # string and the response body.
      #
      # Examples
      #
      #   req.params
      #   # => { "user" => { "username" => "bob" } }
      #
      # Signature
      #
      #   params()
      #
      # Inherited by Rack::Request.
    end
  end
end
