# grape-cors

Adds (simple) support for Cross Origin requests to [grape] - this is particular
useful if you want to host a [Swagger UI explorer](swagger-ui) on a different
domain.

Right now this module only supports a single host (or the '*' wildcard) and GET
requests only. PUT/POST support has yet to be added

## Installation

Add this line to your application's Gemfile:

    gem 'grape-cors'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install grape-cors

## Usage

Add `allow_cross_domain_request_from '*'` to your Grape::API sublcass:


    require 'grape'
    require 'grape-swagger'
    require 'grape-cors'

    class MyApi < Grape::API
    end

    class Root < Grape::API
      mount MyApi

      add_swagger_documentation
      allow_cross_domain_request_from "*"
    end

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Copyright

(c) 2012 Cambridge Healthcare Ltd. All Rights Reserved.

[grape]: https://github.com/intridea/grape
[swagger-ui]: http://swagger.wordnik.com/
