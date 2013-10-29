Railstutor::Application.routes.draw do

  post 'main', to: 'main#create'
  post 'apply', to: 'main#apply'
  get 'veterans', to: 'main#veterans'
  root :to  => "main#index"
end
