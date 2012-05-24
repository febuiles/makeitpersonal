Makeitpersonal::Application.routes.draw do
  devise_for :users

  post "playlists/fetch", :to => "playlists#fetch", :as => "fetch_playlist"

  get "/lyrics", :to => "lyrics#lyrics", :as => "fetch_lyrics"
  resources :user_lyrics

  match "/:id", :to => "playlists#show", :as => "playlist"
  root :to => "pages#index"
end
