require_relative "../test_helper"

class CoreTest < Minitest::Test
  setup do
    Ruter.reset!
  end

  test "hello" do
    Ruter.define do
      get do
        res.write("hello")
      end
    end

    app = Ruter::Test.new
    app.get("/")

    assert_equal 200, app.res.status
    assert_equal "hello", app.res.body
  end

  test "methods" do
    [:get, :post, :put, :patch, :delete].each do |method|
      Ruter.define do
        send(method) { res.write "" }
      end

      app = Ruter::Test.new
      app.send(method, "/")

      assert_equal 200, app.res.status
    end
  end

  test "captures" do
    Ruter.define do
      on :foo do
        on :bar do
          get do
            res.write(sprintf("%s:%s", inbox[:foo], inbox[:bar]))
          end
        end
      end
    end

    app = Ruter::Test.new
    app.get("/foo/bar")

    assert_equal 200, app.res.status
    assert_equal "foo:bar", app.res.body
  end

  test "composition" do
    nested = Class.new(Ruter)

    nested.define do
      get do
        res.write(inbox[:foo])
      end
    end

    Ruter.define do
      on "foo" do
        run(nested, foo: 42)
      end
    end

    app = Ruter::Test.new
    app.get("/foo")

    assert_equal 200, app.res.status
    assert_equal "42", app.res.body
  end

  test "use own request and response classes" do
    Ruter.define do
      get do
        res.write(request_class.name)
        res.write(response_class.name)
      end
    end

    app = Ruter::Test.new
    app.get("/")

    assert_equal 200, app.res.status
    assert_match Ruter::Core::Request.name, app.res.body
    assert_match Ruter::Core::Response.name, app.res.body
  end
end
