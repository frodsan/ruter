Ruter [![Build Status](https://app.travis-ci.com/frodsan/ruter.svg?branch=main)](https://app.travis-ci.com/frodsan/ruter)
====

"You must buy a ticket before entering the bus" - The Inspector 🕵🏻‍♂️

Description
-----------

Ruter is yet another [Rack][rack] based framework, made just for fun, and built on top of [Syro][syro].

Usage
-----

Here's a minimal application:

```ruby
# config.ru
require "ruter"

Ruter.define do
  get do
    res.write("Hello World!")
  end
end

run(Ruter) # run!
```

License
-------

Ruter is released under the [MIT License][mit].

[mit]: http://www.opensource.org/licenses/MIT
[rack]: https://github.com/rack/rack
[syro]: http://soveran.github.io/syro/
