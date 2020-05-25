Rails.application.routes.draw do
  resources :tests do
    resources :questions, except: :index, shallow: true
  end
end
