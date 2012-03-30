# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}


# We want to stub the document fetching so we don't hit LastFm servers.
require 'last_fm/list'
module LastFm
  class List
    def initialize(user)
      @user = user.strip
      mock_document
    end
  end
end
