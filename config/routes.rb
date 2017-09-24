Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :congress do
        get '/members/senate', to: 'members#senate'
        get '/members/house', to: 'members#house'
        get '/members', to: 'members#index'
      end
    end
  end
end
