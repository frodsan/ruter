class Ruter
  # Public: A simple helper class to simulate requests to your application.
  #
  # Examples
  #
  #   require "ruter"
  #   require "ruter/test"
  #
  #   Ruter.define do
  #     root do
  #       res.write("hei")
  #     end
  #   end
  #
  #   app = Ruter::Test.new
  #   app.get("/")
  #
  #   app.res.status # => 200
  #   app.res.body   # => "hei"
  #
  class Test
    # Public: Initializes a new Ruter::Test object.
    #
    # app - The application class to test (default: Ruter).
    #
    # Examples
    #
    #   class API < Ruter
    #   end
    #
    #   app = Ruter::Test.new(API)
    #   app.get("/json")
    #
    def initialize(app = Ruter)
      @app = app
    end

    # Internal: Returns the application class that handles the
    # mock requests. Required by Ruter::Test::InstanceMethods.
    attr_reader :app

    # Internal: This module provides the Ruter::Test API methods.
    # If you don't like the stand-alone version, you can integrate
    # this module to your preferred testing environment.
    #
    # The following example uses Minitest:
    #
    #   class HomeTest < Minitest::Test
    #     include Ruter::Test::InstanceMethods
    #
    #     def app
    #       return Ruter
    #     end
    #
    #     def test_home
    #       get("/")
    #
    #       assert_equal 200, res.status
    #     end
    #   end
    #
    module InstanceMethods
      # Public: Returns the current request object or +nil+ if no requests
      # have been issued yet.
      #
      # Examples
      #
      #   app = Ruter::Test.new
      #   app.get("/", {}, { "HTTP_USER_AGENT" => "Ruter::Test" })
      #
      #   app.req.get?
      #   # => true
      #
      #   app.req.env["HTTP_USER_AGENT"]
      #   # => "Ruter::Test"
      #
      # The returned object is an instance of
      # {Rack::Request}[http://www.rubydoc.info/gems/rack/Rack/Request].
      #
      def req
        @__req
      end

      # Public: Returns the current response object or +nil+ if no requests
      # have been issued yet.
      #
      # Examples
      #
      #   app = Ruter::Test.new
      #   app.get("/", name: "alice")
      #
      #   app.res.status
      #   # => 200
      #
      #   app.res.body
      #   # => "Hello alice!"
      #
      # The returned object is an instance of
      # {Rack::MockResponse}[http://www.rubydoc.info/gems/rack/Rack/MockResponse]
      #
      def res
        @__res
      end

      # Public: Issues a GET request for the given +path+ with the given
      # +params+ and Rack environment.
      #
      # Examples
      #
      #   app = Ruter::Test.new
      #   app.get("/search", name: "alice")
      #
      def get(path, params = {}, env = {})
        request(path, env.merge(method: Rack::GET, params: params))
      end

      # Public: Issues a POST request for the given +path+ with the given
      # +params+ and Rack environment.
      #
      # Examples
      #
      #   app = Ruter::Test.new
      #   app.post("/signup", username: "alice", password: "secret")
      #
      def post(path, params = {}, env = {})
        request(path, env.merge(method: "POST".freeze, params: params))
      end

      # Public: Issues a PUT request for the given +path+ with the given
      # +params+ and Rack environment.
      #
      # Examples
      #
      #   app = Ruter::Test.new
      #   app.put("/users/1", username: "bob", name: "Bob")
      #
      def put(path, params = {}, env = {})
        request(path, env.merge(method: "PUT".freeze, params: params))
      end

      # Public: Issues a PATCH request for the given +path+ with the given
      # +params+ and Rack environment.
      #
      # Examples
      #
      #   app = Ruter::Test.new
      #   app.patch("/users/1", username: "alice")
      #
      def patch(path, params = {}, env = {})
        request(path, env.merge(method: "PATCH".freeze, params: params))
      end

      # Public: Issues a DELETE request for the given +path+ with the given
      # +params+ and Rack environment.
      #
      # Examples
      #
      #   app = Ruter::Test.new
      #   app.delete("/users/1")
      #
      def delete(path, params = {}, env = {})
        request(path, env.merge(method: "DELETE".freeze, params: params))
      end

      # Public: Issues a HEAD request for the given +path+ with the given
      # +params+ and Rack environment.
      #
      # Examples
      #
      #   app = Ruter::Test.new
      #   app.head("/users/1")
      #
      def head(path, params = {}, env = {})
        request(path, env.merge(method: Rack::HEAD, params: params))
      end

      # Public: Issues a OPTIONS request for the given +path+ with the given
      # +params+ and Rack environment.
      #
      # Examples
      #
      #   app = Ruter::Test.new
      #   app.options("/users")
      #
      def options(path, params = {}, env = {})
        request(path, env.merge(method: "OPTIONS".freeze, params: params))
      end

      private

      def request(path, opts = {})
        @__req = Rack::Request.new(Rack::MockRequest.env_for(path, opts))
        @__res = Rack::MockResponse.new(*app.call(@__req.env))
      end
    end

    include InstanceMethods
  end
end
