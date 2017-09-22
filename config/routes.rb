Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :congress do
        resources :members, only: [:index]
      end
    end
  end
end
