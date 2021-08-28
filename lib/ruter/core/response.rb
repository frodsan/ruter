class Ruter
  module Core
    # Public: It provides convenience methods to construct a Rack response.
    #
    # Examples
    #
    #   res = Ruter::Core::Response.new
    #
    #   res.status = 200
    #   res["Content-Type"] = "text/html"
    #   res.write("foo")
    #
    #   res.finish
    #   # => [200, { "Content-Type" => "text/html", "Content-Length" => 3 }, ["foo"]]
    #
    class Response < Syro::Response
      # Public: Initializes a new response object.
      #
      # headers - A Hash of initial headers. Defaults to <tt>{}</tt>.
      #
      # Examples
      #
      #   Ruter::Core::Response.new.headers
      #   # => {}
      #
      #   Ruter::Core::Response.new("Content-Type" => "text/plain").headers
      #   # => { "Content-Type" => "text/plain" }
      #
      # Signature
      #
      #   new(headers = {})
      #
      # Inherited by Syro::Response.

      # Public: Returns the response header corresponding to +key+.
      #
      # key - A String HTTP header field name.
      #
      # Examples
      #
      #     res["Content-Type"]   # => "text/html"
      #     res["Content-Length"] # => "42"
      #
      # Signature
      #
      #   [](key)
      #
      # Inherited by Syro::Response.

      # Public: Sets the given +value+ with the header corresponding to +key+.
      #
      # key   - A String HTTP header field name.
      # value - A String HTTP header field value.
      #
      # Examples
      #
      #     res["Content-Type"] = "application/json"
      #     res["Content-Type"] # => "application/json"
      #
      # Signature
      #
      #   []=(key, value)
      #
      # Inherited by Syro::Response.

      # Public: Returns the body of the response.
      #
      # Examples
      #
      #   res.body
      #   # => []
      #
      #   res.write("there is")
      #   res.write("no try")
      #
      #   res.body
      #   # => ["there is", "no try"]
      #
      # Signature
      #
      #   body()
      #
      # Inherited by Syro::Response.

      # Public: Returns an Array with three elements: the status, headers
      # and body. If the status is not set, the status is set to +404+ if
      # empty body, otherwise the status is set to +200+ and updates the
      # +Content-Type+ header to +text/html+.
      #
      # Examples
      #
      #   res.status = 200
      #   res.finish
      #   # => [200, {}, []]
      #
      #   res.status = nil
      #   res.finish
      #   # => [404, {}, []]
      #
      #   res.status = nil
      #   res.write("yo")
      #   res.finish
      #   # => [200, { "Content-Type" => "text/html", "Content-Length" => 2 }, ["yo"]]
      #
      # Signature
      #
      #   finish()
      #
      # Inherited by Syro::Response.

      # Public: Returns a Hash with the response headers.
      #
      # Examples
      #
      #   res.headers
      #   # => { "Content-Type" => "text/html", "Content-Length" => "42" }
      #
      # Signature
      #
      #   headers()
      #
      # Inherited by Syro::Response.

      # Public: Sets the +Location+ header to +url+ and updates the status
      # to +status+.
      #
      # url    - A String URL (relative or absolute) to redirect to.
      # status - An Integer status code. Defaults to +302+.
      #
      # Examples
      #
      #   res.redirect("/path")
      #
      #   res["Location"] # => "/path"
      #   res.status      # => 302
      #
      #   res.redirect("http://ruter.xyz", 303)
      #
      #   res["Location"] # => "http://ruter.xyz"
      #   res.status      # => 303
      #
      # Signature
      #
      #   redirect(url, status = 302)
      #
      # Inherited by Syro::Response.

      # Public: Returns the status of the response.
      #
      # Examples
      #
      #     res.status # => 200
      #
      # Signature
      #
      #   status()
      #
      # Inherited by Syro::Response.

      # Public: Sets the status of the response.
      #
      # status - An Integer HTTP status code.
      #
      # Examples
      #
      #   res.status = 200
      #
      # Signature
      #
      #   status=(status)
      #
      # Inherited by Syro::Response.

      # Public: Appends +str+ to the response body and updates the
      # +Content-Length+ header.
      #
      # str - Any object that responds to +to_s+.
      #
      # Examples
      #
      #   res.body # => []
      #
      #   res.write("foo")
      #   res.write("bar")
      #
      #   res.body
      #   # => ["foo", "bar"]
      #
      #   res["Content-Length"]
      #   # => 6
      #
      # Signature
      #
      #   write(str)
      #
      # Inherited by Syro::Response.
    end
  end
end
