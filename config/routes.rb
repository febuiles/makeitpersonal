Makeitpersonal::Application.routes.draw do
  get "/lyrics", :to => "lyrics#lyrics", :as => "fetch_lyrics"
  resources :user_lyrics

  root :to => "pages#index"
end
