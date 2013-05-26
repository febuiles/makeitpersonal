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
end
