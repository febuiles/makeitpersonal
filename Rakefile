#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Makeitpersonal::Application.load_tasks

task generate_sitemap: :environment do
  desc "Generates a sitemap.xml file for the site"
  SitemapGenerator::Sitemap.default_host = 'http://makeitpersonal.co'
  SitemapGenerator::Sitemap.create do
    add '/', :changefreq => 'weekly'
    User.all.each do |user|
      add "/#{user.username}", :changefreq => "daily"
    end
  end

  SitemapGenerator::Sitemap.ping_search_engines
end

namespace :db do
  task :pull => :environment do
    desc "Drops the database and recreates it from the dump file"
    system "cap db:download && gunzip dump.gz"
    system %q{psql -h localhost -c "SELECT pg_terminate_backend(pid) FROM pg_stat_activity WHERE  pid <> pg_backend_pid() AND datname = 'makeitpersonal_development'"}
    system "rake db:drop db:create"
    system "psql -U federico -h localhost -d makeitpersonal_development -f dump"
    system "rm dump"
  end
end

