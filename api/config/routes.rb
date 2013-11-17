ApiDemo::Application.routes.draw do

  resources :users, except: [:edit, :new]

end
