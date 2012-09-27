Makeitpersonal::Application.routes.draw do
  devise_for :users

  get "/lyrics", :to => "lyrics#lyrics", :as => "fetch_lyrics"
  resources :user_lyrics

  get "/disclaimer", to: "pages#disclaimer"
  get "/contact", to: "pages#contact"
  get "/credits", to: "pages#credits"

  root :to => "pages#index"
end
