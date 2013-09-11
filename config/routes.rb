MygovForms::Application.routes.draw do
  resources :users, :only => [:index, :show, :edit, :update ]
  get '/auth/:provider/callback' => 'sessions#create'
  get '/signin' => 'sessions#new', :as => :signin
  get '/signout' => 'sessions#destroy', :as => :signout
  get '/auth/failure' => 'sessions#failure'

  resources :forms, :only => [:index, :show] do
    resources :submissions, :only => [:show, :create]
  end

  get 'forms/:id/start', to: 'forms#start'

  namespace :api, :defaults => {:format => :json} do
    resources :forms, :only => [:index, :show] do
      member do
        post "fill_pdf"
      end
      resources :submissions, :only => [:show, :create]
    end
  end
  root :to => 'forms#index'
end
