require "grape-cors/version"

module Grape
  module Cors
    def self.allowed_methods_for_all_routes(grape)
      allowed_methods = Hash.new{|h,k| h[k] = [] }
      resources = grape.endpoints.map do |endpoint|
        endpoint.options[:app] && endpoint.options[:app].respond_to?(:endpoints) ?
          endpoint.options[:app].endpoints.map(&:routes) :
          endpoint.routes
      end
      resources.flatten.each do |route|
        allowed_methods[route.route_path] << route.route_method
      end

      allowed_methods
    end

    module InstanceMethods
      def initialize
        # Add our OPTIONS route before grape adds its default one
        add_cors_compatible_options_methods
        super
      end

      def add_cors_compatible_options_methods
        Grape::Cors.allowed_methods_for_all_routes(self.class).each do |path_info, methods|
          unless methods.include?("OPTIONS")
            allow_header = (["OPTIONS"] | methods).join(", ")

            self.class.options path_info do
              status 204
              # The A-C-Allow-Origin is added by the before block
              header 'Access-Control-Allow-Methods', allow_header
              # This list might need changing for various browsers :/ Should we
              # just echo back what ever the server sent us instead?
              header 'Access-Control-Allow-Headers', "origin, content-type, accept"
              header 'Allow', allow_header
              body ""
            end
          end
        end
      end
    end
  end
end

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

      # If we add the OPTIONS methods now we might do it before all the routes
      # are added, so include a module that wraps initialize (which is where
      # the route set is frozen)
      self.send :include, Grape::Cors::InstanceMethods

    end
  end
end
