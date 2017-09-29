Makeitpersonal::Application.routes.draw do
  # devise_for :users, :controllers => { :registrations => "registrations" }

  # devise_scope :user do
  #   get '/login' => "devise/sessions#new",       :as => :new_user_session
  #   post '/login' => 'devise/sessions#create',    :as => :user_session
  #   delete '/logout' => 'devise/sessions#destroy',   :as => :destroy_user_session
  #   get "/signup" => "registrations#new", :as => :new_user_registration
  #   get "/account/settings" => "registrations#edit", :as => :edit_user_registration
  # end

  get "/user_lyrics/:id", to: "pages#index" # workaround v1.
  get "/lyrics", :to => "lyrics#lyrics", :as => "fetch_lyrics"
  get "/disclaimer", to: "pages#disclaimer"
  get "/contact", to: "pages#contact"
  post "/contact", to: "pages#contact_form"
  get "/credits", to: "pages#credits"
  get "/manifesto", to: "pages#manifesto"
  get "/:username/followers", to: "relationships#followers", :as => :followers
  get "/:username/following", to: "relationships#following", :as => :followings

  # user
  get "/account", :to => "users#show", :as => :account
  get "/loved", :to => "loves#loved", :as => :loved_songs
  get "/loves", :to => "loves#loves", :as => :loves_received

  resources :songs, except: [:index, :show]
  resources :relationships, only: [:create, :destroy]
  resources :loves, only: [:create, :destroy]


  root :to => "pages#index"

  # songs
  get "/:username/:id", :to => "songs#show", :as => "user_song"
  get "/:username", :to => "songs#index", :as => "user"

end
