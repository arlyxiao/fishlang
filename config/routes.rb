Fishlang::Application.routes.draw do
  get "home/index"

  resources :sentences do
    member do
      post :check
    end

    collection do
    end
  end

  root :to => 'home#index'
end
