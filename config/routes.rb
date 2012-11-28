MygovForms::Application.routes.draw do
  resources :forms do
    resources :submissions
  end

  namespace :api, :defaults => {:format => :json} do
    resources :forms, :only => [:index, :show, :create] do
      member do
        post "fill_pdf"
      end
      resources :submissions, :only => [:show, :create]
    end
  end

  root :to => 'forms#index'
  
end
