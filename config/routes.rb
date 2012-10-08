Corpo::Application.routes.draw do
  
  resources :helps

  resources :corporation_saldos

  resources :corporation_debits

  resources :news

  resources :corporation_payments

  get "pages/index"

  get "pages/about"

  devise_for :users

  resources :abonent_tarifs
  resources :abonent_debits
  resources :abonent_payments
  resources :rate_corpos

  resources :abonent_saldos do
    collection do
      get 'recalc'
    end
  end

  resources :abonents
  match 'abonent_payment/check/:corporation_phone/:phone/:amount' => 'abonent_payments#check'
  match 'abonent_payment/pay/:platika_id/:corporation_phone/:phone/:amount' => 'abonent_payments#pay'
  match 'instruction' => 'helps#instruction'
  match 'abonent_payment/inback/:platika_id/:corporation_phone/:phone/:amount' => 'abonent_payments#inback'
  resources :corporations

  root :to => "corporations#index" 
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
