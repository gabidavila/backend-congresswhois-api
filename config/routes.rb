Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :congress do
        get '/parties/representation', to: 'parties#representation'
        get '/states', to: 'states#index'
        get '/states/:id', to: 'states#show'
        get '/members/senate', to: 'members#senate'
        get '/members/house', to: 'members#house'
        get '/members/:id', to: 'members#show'
        get '/members', to: 'members#index'
        post '/compare', to: 'comparisons#compare'
        get '/bills', to: 'bills#index'
        get '/bills/:id', to: 'bills#show'
      end
      namespace :zipcodes do
        get '/districts/search', to: 'districts#search'
      end
    end
  end
  post '/twilio/voice', to: 'twilio#voice'
  get '/twilio/token', to: 'twilio#token'
end
