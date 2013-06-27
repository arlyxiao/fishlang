Fishlang::Application.routes.draw do
  get "home/index"

  resources :lessons

  resources :practices

  resources :sentences do
    member do
      post :check
      get :continue
    end

    collection do
    end
  end


  namespace :admin do

    resources :lessons, :shallow => true do
      resources :practices, :shallow => true do
        resources :sentences, :shallow => true
      end
    end

  end


  root :to => 'home#index'
end
