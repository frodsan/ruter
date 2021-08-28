require_relative "../test_helper"

class SettingsTest < MiniTest::Test
  setup do
    Ruter.reset!
    Ruter.settings.clear
  end

  test "set and get setting" do
    Ruter.set(:environment, "development")

    assert_equal "development", Ruter.settings[:environment]
  end

  test "get setting inside handler" do
    Ruter.set(:environment, "development")

    Ruter.define do
      get do
        res.write(settings[:environment])
      end
    end

    app = Ruter::Test.new
    app.get("/")

    assert_equal 200, app.res.status
    assert_equal "development", app.res.body
  end

  test "inheritance" do
    Ruter.set(:foo, "foo")
    Ruter.set(:bar, "bar")

    Inherited = Class.new(Ruter)
    Inherited.set(:bar, "rab")
    Inherited.set(:baz, "baz")

    assert_equal "foo", Ruter.settings[:foo]
    assert_equal "bar", Ruter.settings[:bar]
    assert_nil Ruter.settings[:baz]

    assert_equal "foo", Inherited.settings[:foo]
    assert_equal "rab", Inherited.settings[:bar]
    assert_equal "baz", Inherited.settings[:baz]
  end
end
