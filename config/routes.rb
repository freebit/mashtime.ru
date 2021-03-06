Masha::Application.routes.draw do
  ActiveAdmin.routes(self)

  root 'welcome#index'

  get '/auth/:provider/callback', to: 'omniauth_session#create'
  post '/auth/:provider/callback', to: 'omniauth_session#create'
  # TODO Добавить routes для отработки
  # http://masha.brandymint.ru/auth/failure?message=invalid_credentials&strategy=github

  get 'logout' => 'sessions#destroy', :as => 'logout'
  get 'login' => 'sessions#new', :as => 'login'
  get 'signup' => 'users#new', :as => 'signup'
  get 'feedback' => 'pages#feedback', :as => 'feedback'
  get 'noaccess' => 'pages#noaccess', :as => 'noaccess'
  get 'support' => redirect('/feedback')
  get 'error' => 'errors#index', :as => 'error'

  resources :users, only: [:new, :create]
  resources :sessions, only: [:new, :create, :destroy]

  # Личный контроллер пользователя
  resource :profile, controller: :profile do
    collection do
      post :change_password
    end
  end

  resources :password_resets, only: [:new, :create, :edit, :update]

  resources :projects do
    resources :memberships
    member do
      put :activate
      put :archivate
    end
  end
  resources :time_shifts do
    collection do
      get :summary
    end
  end
  resources :invites, only: [:create, :destroy]

  namespace :owner do
    root controller: :users, action: :index
    resources :projects do
      resources :memberships

      member do
        post :set_role
        delete :remove_role
      end
    end
    resources :users
  end

  resources :users
end
