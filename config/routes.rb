Rails.application.routes.draw do

  devise_for :admins, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root to: 'home#welcome'
  get 'login', to: 'home#login'
  get 'register', to: 'home#register'

  devise_for :receivers, controllers: { registrations: "registrations", sessions: "sessions" }
  devise_for :donors, controllers: { registrations: "registrations", sessions: "sessions" }
  resources :donors do
    resources :foods
    resources :donations, except: [:new] do
      resources :donation_items, only: [:new, :create, :index, :destroy]
      resources :receivers, only: [:index, :show]
    end
  end
  resources :receivers, only: [:show, :index, :edit, :update] do
    resources :contact_details
    resources :demographics
    resources :programs
    resources :logistics
    resources :restrictions
    resources :donation_schedules, path: 'schedule'
    resources :donations do
      resources :donation_items, only: [:new, :create, :index]
    end
  end

  get 'receivers/:id/details', to: 'receivers#details', as: 'receiver_details'
  get 'receivers/:id/verify', to: 'receivers#verify', as: 'verify_receiver'
  get 'receivers/:id/check_verification', to: 'receivers#check_verification', as: 'check_verification_receiver'

  get 'receivers/:id/pause', to: 'receivers#pause', as: 'pause_receiver'
  get 'receivers/:id/unpause', to: 'receivers#unpause', as: 'unpause_receiver'
  get 'receivers/:id/confirm_intake', to: 'receivers#confirm_intake', as: 'receiver_registration_confirmation'
  get 'receivers/:id/thank_you', to: 'receivers#thank_you', as: 'receiver_thank_you'

  get 'donations/:id/add_receiver', to: 'donations#add_receiver', as: 'donation_add_receiver'
  get 'donations/:id/receive', to: 'donations#receive', as: 'donation_receive'
  get 'donations/:id/donate', to: 'donations#donate', as: 'donation_donate'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
