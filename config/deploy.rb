require "bundler/capistrano"
require "sitemap_generator"

server "50.97.51.122", :web, :app, :db, primary: true

set :application, "makeitpersonal"
set :user, "mip"
set :deploy_to, "/home/#{user}/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false
set :scm, "git"
set :repository, "git@github.com:febuiles/#{application}.git"
set :branch, "master"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

namespace :deploy do
  task :setup_config, roles: :app do
    run "mkdir -p #{shared_path}/config"
    put File.read("config/database.example.yml"), "#{shared_path}/config/database.yml"
    puts "Now edit the config files in #{shared_path}."
  end
  after "deploy:setup", "deploy:setup_config"

  task :symlink_config, roles: :app do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end

  desc "Make sure local git is in sync with remote."
  task :check_revision, roles: :web do
    unless `git rev-parse HEAD` == `git rev-parse origin/master`
      puts "WARNING: HEAD is not the same as origin/master"
      puts "Run `git push` to sync changes."
      exit
    end
  end

  desc "Generates a sitemap.xml file for the site"
  task :generate_sitemap do
    run "cd #{release_path} && bundle exec rake generate_sitemap"
  end

  before "deploy", "deploy:check_revision"
  before "deploy:restart", "deploy:symlink_config"
  after "deploy", "deploy:generate_sitemap"
  after "deploy", "deploy:cleanup"
end

namespace :db do
  desc "Pull the database to localhost"
  task :download do
    local = "/Users/federico/dev/makeitpersonal"
    run "pg_dump -U mip makeitpersonal_production | gzip -c > #{current_path}/dump.gz"
    system "scp mip@mip:#{current_path}/dump.gz #{local}"
    run "rm #{current_path}/dump.gz"
  end
end
