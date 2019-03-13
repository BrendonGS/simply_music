Rails.application.routes.draw do
 namespace :api do
  post '/users' => 'users#create'  
  get '/users/:id' => 'users#show'  
  post '/sessions' => 'sessions#create'

  get '/songs' => 'songs#index'
  post '/songs' => 'songs#create'
  get '/songs/:id' => 'songs#show'
  patch '/songs/:id' => 'songs#update'
  delete '/songs/:id' => 'songs#destroy'

  get '/chords' => 'chords#index'
  post '/chords' => 'chords#create'
  get '/chords/:id' => 'chords#show'
  patch '/chords/:id' => 'chords#update'
  delete '/chords/:id' => 'chords#destroy'

 end
end
