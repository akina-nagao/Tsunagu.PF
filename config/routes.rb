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
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
