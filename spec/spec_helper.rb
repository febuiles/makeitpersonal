# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  config.mock_with :rspec
end

def stub_last_fm
  list = mock(:songs => [1, 2, 3])
  list.stub(:between).and_return(list)
  list.stub(:to_json).and_return(%w(1 2 3))
  LastFm::List.stub!(:new).and_return(list)
end
