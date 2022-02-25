Rails.application.routes.draw do

  post '/games'       => 'games#create'
  put  '/games/:id'   => 'games#update'
  get  '/games/:id'   => 'games#show'

  root to: "main#index"
end
