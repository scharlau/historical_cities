Rails.application.routes.draw do
  resources :cities
  get 'countries', to: 'cities#countries'
  get 'citylist', to: 'cities#citylist'
  get 'citynames', to: 'cities#citynames'
  get 'search', to: 'cities#search'
  #get '/barchartcities', to: static('barchartcities.json')
# set the root to the main page - later we can add something else
  root to: 'cities#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
