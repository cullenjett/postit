PostitTemplate::Application.routes.draw do
  root to: 'posts#index'


  # get '/posts', to: 'posts#index'
  # get '/posts/:id', to: 'posts#show'
  # get '/posts/new', to: 'posts#new'
  # post '/posts', to: 'post#create'
  # get '/posts/:id/edit', to: 'post#edit'
  # patch '/posts/:id', to: 'post#update'


  resources :posts, except: [:destroy] do
    resources :comments, only: [:create]
  end

  resources :categories, only: [:show, :new, :create]
end
