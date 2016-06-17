Rails.application.routes.draw do

match "/delayed_job" => DelayedJobWeb, :anchor => false, via: [:get, :post]

resources :password_resets, only: [:new, :create, :edit, :update]
  #Controller Namespaces and Routing
  # namespace :admin do
  #   resources :questions
  # end

  # scope module: 'admin' do
  #   resources :questions
  # end
#This defined a route so that when we receive a GET request with url: /home Rails will invoke the WelcomeController with the 'index' action.
# THIS IS THE SAME AS GET({"/home" => "welcome#index"}) simply a function get, that takes as argument () a Hash {}.
#if we don't specify a helper method name, it will default in this case to 'home_path' and 'home_url'
  get "/home" => "welcome#index"

#For this route we will have helper methods: about_us_path and about_us_url
  get "/about" => "welcome#about", as: :about_us

  #this defines the 'root' or home page of our application to go to the WelcomeController with 'index' action. We will have access to the helper methods: root_path and root_url
  root "welcome#index"

  get "/contact_us" => "contact_us#new"
  post "/contact_us" => "contact_us#create"


  resources :users, only: [:new, :create]

  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
    # delete :destroy, on: :member
    # delete :destroy
  end


  resources :questions do
    # get :search, on: :collection
    # get :search, on: :member
    # get :search


    # the answers routes will be the standard ones prefixed with /questions/:question_id
    # this way if we want to create an answer, we know the question that it references
    # all the helpers will be the same as before, prefixed with 'question_'
    resources :answers, only: [:create, :destroy, :edit, :update]
    resources :likes, only: [:create, :destroy]
    resources :votes, only: [:create, :update, :destroy]
    resources :insights, only: [:create]
  end
  # get     "/questions/new"       => "questions#new",      as: :new_question
  # post    "/questions"           => "questions#create",   as: :questions
  # get     "/questions/:id"       => "questions#show",     as: :question
  # get     "/questions"           => "questions#index"
  # get     "/questions/:id/edit"  => "questions#edit",     as: :edit_question
  # patch   "/questions/:id"       => "questions#update"
  # delete  "/questions/:id"        => "questions#destroy"



  # Write routing code that does the following:

  # (HTTP Verb: delete - path: /questions/:id ) ==> questions controller / destroy action
  # delete "/questions/:id" => "questions#destroy"
  # # (HTTP Verb: get - path: /questions/:id/edit ) ==> questions controller / edit action
  # get "/questions/:id/edit" => "questions#edit"
  # # (HTTP Verb: get - path: /questions/:id ) ==> questions controller / show action
  # get "/questions/:id" => "questions#show", as: :question
  # # (HTTP Verb: post - path: /questions/:id/comments ) ==> comments controller / create action
  # post "/questions/:id/comments" => "comments#create"
  # # (HTTP Verb: get - path: /faq ) ==> home controller / faq action
  # get "/faq" => "home#faq"

# Find out how to do the following route:
# HTTP Verb: GET with URL: /admin/questions == Routes to ==> questions controller inside a folder called `admin` (inside the app/controllers folder). The action should be `index`

  # get "/admin/questions" => "admin/questions#index"



get "/questions" => "questions#index"



# Alternatively, find out to how to do the route differently:
#
# HTTP Verb: GET with URL: /admin/questions == Routes to ==> questions controller with `index` action.

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
