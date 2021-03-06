Fishlang::Application.routes.draw do

  devise_for :users

  resources :lessons do
    collection do
      get :exam
    end
  end

  resources :practices do
    collection do
      get :exam
      get :done
    end
  end

  resources :sentences do
    member do
      post :check
      get :continue
      post :report
    end

  end

  resources :sentence_failures do
    collection do
      get :exam
    end
  end


  namespace :admin do
    root :to => 'index#index'

    resources :users

    resources :lessons, :shallow => true do

      resources :practices, :shallow => true do
        resources :sentences, :shallow => true do
          resources :sentence_translations
        end
      end

    end

    resources :sentence_reports

  end


  root :to => 'lessons#index'
end
