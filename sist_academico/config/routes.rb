SistAcademico::Application.routes.draw do

  resources :configuraciones


  resources :helps
  resources :noticias 

  resources :reports do
    collection do
      get :consult_between
    end
    collection do
      get :change_data
    end
    collection do
      get :alumnos
    end
  end

  resources :auditorias do
    member do
      post :index
    end
  end

  resources :calificaciones do
    collection do
      get :change_data
    end
    collection do
      get :change_select
    end
    collection do
      get :change_etapa
    end
  end


  resources :puntajes
  resources :materiales do
    member do
      get :download_file
    end
  end

  resources :planificaciones


  resources :materias do
    member do
      get :change_data
    end
    member do
      get :edit_campos
    end
    member do
      get :materias_calificaciones
    end
    collection do
      get :index_total
    end
  end
 
  resources :administrativos
  resources :docentes do
    collection do
      get :index_total
    end
  end

  resources :alumnos do
    member do
      get :alumno_calificaciones
    end
    member do
      get :change_curso
    end
    collection do
      get :index_total
    end
    collection do
      get :find_alumnos
    end
  end

  resources :cursos do
    collection do
      get :index_total
    end
    collection do
      get :change_select
    end
  end


  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  get "signup" => "users#new", :as => "signup"
  resources :users
  resources :sessions
  resources :addresses
  resources :cities
  resources :countries
 


  match '/help',    to: 'static_pages#help'
  match '/about',   to: 'static_pages#about'
  match '/contact', to: 'static_pages#contact'
  root to: 'static_pages#home'

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
  # match ':controller(/:action(/:id))(.:format)'
end
