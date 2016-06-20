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
  desc 'close existing DB connections'
  task :close => :environment do
    database = Rails.configuration.database_configuration[Rails.env]["database"]
    cmd = %(psql -c "SELECT pg_terminate_backend(pid) FROM pg_stat_activity WHERE pid <> pg_backend_pid() AND datname = '#{database}';" -d '#{database}')
    system(cmd)
  end
  task 'db:drop' => 'db:close'

  desc "Creates a dump of the database"
  task :dump => :environment do
    db_config = Rails.configuration.database_configuration[Rails.env]
    system "pg_dump -U #{db_config["username"]} #{db_config["database"]} | gzip -c > dump.gz"
  end

  desc "Drops the database and recreates it from a dump file"
  task :download => [:environment, :close] do
    config = Rails.configuration.database_configuration[Rails.env]
    database = config["database"]
    db_user = config["username"]

    system "cap production db:download && gunzip dump.gz"
    system "rake db:drop db:create"
    system "psql -f dump -d #{database} -U #{db_user} && rm dump"
  end
end
