Makeitpersonal::Application.routes.draw do
  devise_for :users

  get "/lyrics", :to => "lyrics#lyrics", :as => "fetch_lyrics"
  get "/disclaimer", to: "pages#disclaimer"
  get "/contact", to: "pages#contact"
  get "/credits", to: "pages#credits"


  # user
  get "/account", :to => "users#show", :as => "account"

  root :to => "pages#index"

  # songs
  get "/:username/:id", :to => "songs#show", :as => "user_song"
  get "/:username", :to => "songs#index", :as => "user"

end
