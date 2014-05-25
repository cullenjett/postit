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


  resources :users, only: [:create, :show, :edit, :update]
  get '/register', to: 'users#new'


  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
end
