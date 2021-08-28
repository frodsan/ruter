require_relative "../test_helper"

class MiddlewareTest < Minitest::Test
  class ReverseBody
    def initialize(app)
      @app = app
    end

    def call(env)
      status, headers, body = @app.call(env)

      [status, headers, body.reverse]
    end
  end

  setup do
    Ruter.reset!
  end

  test "middleware in main application" do
    Ruter.use(ReverseBody)

    Ruter.define do
      get do
        res.write("1")
        res.write("2")
      end
    end

    app = Ruter::Test.new
    app.get("/")

    assert_equal 200, app.res.status
    assert_equal "21", app.res.body
  end

  test "middleware with composition" do
    Ruter.use(ReverseBody)

    api = Class.new(Ruter) do
      define do
        get do
          res.write("1")
          res.write("2")
        end
      end
    end

    Ruter.define do
      on "api" do
        run(api)
      end
    end

    app = Ruter::Test.new
    app.get("/api")

    assert_equal 200, app.res.status
    assert_equal "21", app.res.body
  end

  test "middleware only in child application" do
    api = Class.new(Ruter) do
      use(ReverseBody)

      define do
        get do
          res.write("1")
          res.write("2")
        end
      end
    end

    Ruter.define do
      on "api" do
        run(api)
      end

      get do
        res.write("not_reversed")
      end
    end

    app = Ruter::Test.new
    app.get("/api")

    assert_equal 200, app.res.status
    assert_equal "21", app.res.body

    app.get("/")

    assert_equal 200, app.res.status
    assert_equal "not_reversed", app.res.body
  end
end
