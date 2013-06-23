Fishlang::Application.routes.draw do
  get "home/index"

  resources :sentences do
    member do
      post :check
      get :continue
    end

    collection do
    end
  end

  root :to => 'home#index'
end
