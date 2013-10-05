Railstutor::Application.routes.draw do

  post 'main', to: 'main#create'
  root :to  => "main#index"
end
