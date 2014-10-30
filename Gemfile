source "http://rubygems.org"

gem "rails", "3.2.20"
gem "pg"
gem "nokogiri"
gem "jquery-rails"
gem "airbrake"
gem "devise", "2.1.3"
gem "twitter-bootstrap-rails", "2.1.4"
gem "friendly_id", ">= 4.0.9"
gem "redcarpet"
gem "rack-timeout"
gem "mixpanel"
gem "rails3_acts_as_paranoid", "~> 0.2.0"
gem "unicorn"
gem "kaminari"

group :development do
  gem "capistrano"
  gem "capistrano-rails", "~> 1.0.0"
  gem "capistrano-bundler"
  gem "capistrano-rbenv" , github: "capistrano/rbenv"
end

group :production do
  gem "sitemap_generator"
end

group :development, :test do
  gem "rspec-rails"
  gem "factory_girl_rails"
end

group :assets do
  gem "sass-rails",   "~> 3.2.3"
  gem "uglifier", ">= 1.0.3"
  gem "coffee-rails", "~> 3.2.1"
end
