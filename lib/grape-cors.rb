require "grape-cors/version"

# A very siple helper class. Will probably be extened to deal with OPTIONS
# requests for POST/PUT in the future. If this happens it's probably worth
# open-sourcing this module
module Grape
  class API
    # Allow Cross domain requests from uri (or '*' for everything).
    #
    # If we want to allow CORS from more than one domain (but not *) then we'll
    # need to examine the Origin request header and echo that back if access is
    # allowed
    def self.allow_cross_domain_request_from(uri)
      before do
        header "Access-Control-Allow-Origin", uri
      end
    end
  end
end
