set :application, "makeitpersonal"
set :repo_url, "git@github.com:febuiles/makeitpersonal.git"

set :deploy_to, "/var/www/makeitpersonal"
set :scm, :git
set :branch, "master"

set :linked_files, %w{config/database.yml}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  desc "Make sure local git is in sync with remote."
  task :check_revision do
    on roles(:web) do
      unless `git rev-parse HEAD` == `git rev-parse origin/master`
        puts "WARNING: HEAD is not the same as origin/master"
        puts "Run `git push` to sync changes."
        exit
      end
    end
  end

  # desc "Generates a sitemap.xml file for the site"
  # task :generate_sitemap do
  #   with rails_env: :production do
  #     rake "generate_sitemap"
  #   end
  # end

  after :publishing, :restart
  after :finishing, 'deploy:cleanup'
  # after :finishing, 'deploy:generate_sitemap'
end

namespace :db do
  desc "Creates a dump of the database"
  task :download do
    on roles(:app) do
      within(release_path) do
        with rails_env: "production" do
          rake "db:dump"
          download! "#{deploy_to}/current/dump.gz", "dump.gz"
          execute :rm, "dump.gz"
        end
      end
    end
  end
end
