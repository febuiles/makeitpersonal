Makeitpersonal::Application.routes.draw do

  post "playlists/fetch", :to => "playlists#fetch", :as => "fetch_playlist"

  get "/lyrics", :to => "lyrics#lyrics", :as => "fetch_lyrics"
  resources :lyrics, :except => [:index]

  match "/:id", :to => "playlists#show", :as => "playlist"
  root :to => "playlists#new"
end
