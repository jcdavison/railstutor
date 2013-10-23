Railstutor::Application.routes.draw do

  post 'main', to: 'main#create'
  get 'veterans', to: 'main#veterans'
  root :to  => "main#index"
end
