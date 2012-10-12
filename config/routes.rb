Makeitpersonal::Application.routes.draw do
  devise_for :users, :controllers => { :registrations => "registrations" }

  devise_scope :user do
    get '/login' => "devise/sessions#new",       :as => :new_user_session
    post '/login' => 'devise/sessions#create',    :as => :user_session
    delete '/logout' => 'devise/sessions#destroy',   :as => :destroy_user_session
    get "/signup" => "devise/registrations#new", :as => :new_user_registration
    get "/account/settings" => "registrations#edit", :as => :edit_user_registration
  end

  get "/lyrics", :to => "lyrics#lyrics", :as => "fetch_lyrics"
  get "/disclaimer", to: "pages#disclaimer"
  get "/contact", to: "pages#contact"
  get "/credits", to: "pages#credits"

  resources :songs, :except => [:index, :show]

  # user
  get "/account", :to => "users#show", :as => "account"

  root :to => "pages#index"

  # songs
  get "/:username/:id", :to => "songs#show", :as => "user_song"
  get "/:username", :to => "songs#index", :as => "user"

end
