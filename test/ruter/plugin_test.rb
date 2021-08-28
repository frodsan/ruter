require_relative "../test_helper"
require "redcarpet"

class MarkdownPlugin
  def self.setup(app, options = {})
    app.settings[:markdown_options] = options
  end

  module ClassMethods
    def markdown_renderer
      @_markdown_renderer ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML, markdown_options)
    end

    def markdown_options
      settings[:markdown_options]
    end
  end

  module InstanceMethods
    def markdown(text)
      res.write(self.class.markdown_renderer.render(text))
    end
  end
end

class MarkdownApp < Ruter
  plugin(MarkdownPlugin, no_intra_emphasis: true)

  define do
    root do
      get do
        markdown("This is *bongos*, indeed.")
      end
    end
  end
end

class PluginTest < Minitest::Test
  test "setup" do
    refute_nil(MarkdownApp.settings[:markdown_options])
  end

  test "class methods" do
    assert_instance_of(Redcarpet::Markdown, MarkdownApp.markdown_renderer)
  end

  test "instance methods" do
    app = Ruter::Test.new(MarkdownApp)
    app.get("/")

    assert_equal 200, app.res.status
    assert_match "<p>This is <em>bongos</em>, indeed.</p>", app.res.body
  end
end
