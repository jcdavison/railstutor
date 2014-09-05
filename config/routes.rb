Railstutor::Application.routes.draw do

  post 'main', to: 'main#create'
  post 'join', to: 'main#join'
  get 'veterans', to: redirect("/")
  get 'apply', to: 'main#apply'
  root :to  => "main#index"
end
