Rails.application.routes.draw do

  
  devise_for :admins, path: 'admin', controllers: {
    sessions: 'admin/admins/sessions'
  }

  devise_for :customers, controllers: {
    sessions: 'public/customers/sessions',
    registrations: 'public/customers/registrations'
  }

  namespace :admin do
    root 'home#top'
  end

  scope module: :public do
    root 'home#top'
    resources :posts do
      resource :favorites, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]
      resource :tags, only: [:create]
      #resource :post_membersbers, only: [:create, :destroy]
    end
    resources :tags
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
