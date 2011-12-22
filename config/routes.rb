LastPlaylist::Application.routes.draw do
  resources :playlists
  post "playlists/fetch", :to => "playlists#fetch", :as => "fetch_playlist"
  root :to => "playlists#new"
end
