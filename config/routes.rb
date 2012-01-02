Makeitpersonal::Application.routes.draw do
  resources :playlists
  post "playlists/fetch", :to => "playlists#fetch", :as => "fetch_playlist"

  match "/:id", :to => "playlists#show", :as => "playlist"
  root :to => "playlists#new"
end
