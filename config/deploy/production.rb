set :stage, :production

role :app, %w{mip@makeitpersonal.co}
role :web, %w{mip@makeitpersonal.co}
role :db, %w{mip@makeitpersonal.co}

set :ssh_options, {
  forward_agent: true
}
