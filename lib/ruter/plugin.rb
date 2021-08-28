class Ruter
  # Public: Ruter's plugin system.
  module Plugin
    # Public: Loads given +plugin+ into the application.
    #
    # Examples
    #
    #   require "ruter"
    #   require "ruter/protection"
    #   require "ruter/session"
    #
    #   # Use some standard plugins
    #
    #   Ruter.plugin(Ruter::Protection)
    #   Ruter.plugin(Ruter::Session, secret: "__a_random_secret_key__")
    #
    #   # Make your own custom plugin:
    #
    #   require "redcarpet"
    #
    #   class MarkdownPlugin
    #     def self.setup(app, options = {})
    #       app.settings[:markdown_options] = options
    #     end
    #
    #     module ClassMethods
    #       def markdown_renderer
    #         @_markdown_renderer ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML, markdown_options)
    #       end
    #
    #       def markdown_options
    #         settings[:markdown_options]
    #       end
    #     end
    #
    #     module InstanceMethods
    #       def markdown(text)
    #         res.write(markdown_renderer.render(text))
    #       end
    #     end
    #   end
    #
    #   Ruter.plugin(MarkdownPlugin, fenced_code_blocks: true)
    #
    #   Ruter.define do
    #     root do
    #       get do
    #         markdown("This is *bongos*, indeed.")
    #       end
    #     end
    #   end
    #
    def plugin(plugin, *args, &block)
      if defined?(plugin::InstanceMethods)
        include(plugin::InstanceMethods)
      end

      if defined?(plugin::ClassMethods)
        extend(plugin::ClassMethods)
      end

      if plugin.respond_to?(:setup)
        plugin.setup(self, *args, &block)
      end
    end
  end
end
