Billbeez::Application.routes.draw do

  get "/suppliers/:id/url", to: 'suppliers#url'
  get "/suppliers/list", to: 'suppliers#list'
  
  resources :dues
  resources :notifications
  resources  :reminders
  resources :plans
  resources :suppliers

  resources :newsletters do
    member do
      get 'deliver'
    end
  end

  resources :customers do
    resources :bills
  end

  resources :customers do
    resources :newsletters do
      resources :bills do
        get :autocomplete_supplier_name
      end
      resources :dues do
        resources :lines
      end
      resources :notifications do
        resources :charges
        resources :lines
      end
      resources :reminders
      resources :plans do
        resources :features
      end
    end
  end
  
#  patch customers/:customer_id/newsletters/:newsletter_id/dues/:due_id/lines

  resources :versions do
    resources :newsletters
  end
  
  resources :campaigns do
    resources :versions
  end
  
  resources :versions do
    member do
      put 'modify','approve', 'unapprove'
    end
  end

  devise_for :users, :controllers => { :sessions => "sessions" }
  root "home#index"
  get "user_mailer/weekly"
  get "sample_mailer/weekly"
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
