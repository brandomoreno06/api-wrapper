Rails.application.routes.draw do
  
  namespace :api do
    get '/games/stores' => 'games#stores'
    get '/games' => 'games#index'
    get '/games/:id' => 'games#posts'
    get '/games/:id/posts' => 'games#posts'
    get '/games/:id/trailers' => 'games#trailers'
    
  end
end
