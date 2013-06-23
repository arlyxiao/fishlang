Fishlang::Application.routes.draw do
  get "home/index"

  

  resources :lessons, :shallow => true do

    resources :sentences, :shallow => true do
      
      member do
        post :check
        get :continue
      end

    end


  end

  root :to => 'home#index'
end
