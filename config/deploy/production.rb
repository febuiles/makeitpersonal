set :stage, :production

role :app, %w{mip@107.170.105.41}
role :web, %w{mip@107.170.105.41}
role :db, %w{mip@107.170.105.41}

set :ssh_options, {
  forward_agent: true
}
