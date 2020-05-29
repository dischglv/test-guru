Rails.application.routes.draw do
  resources :tests do
    resources :questions, except: :index, shallow: true do
      resources :answers, shallow: true
    end
  end
end
