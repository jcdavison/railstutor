Railstutor::Application.routes.draw do

  post 'main', to: 'main#create'
  post 'join', to: 'main#join'
  get 'veterans', to: redirect("/")
  get 'apply', to: 'main#apply'
  get 'freelance', to: 'main#freelance'
  ["views", "controllers", "rubybasics", "models", "mvcroundtrip", "rubyobjects", "overview" ].each do |lesson|
    get "curriculum/#{lesson}", to: "curriculum##{lesson}"
  end
  get "curriculum/", to: "curriculum#overview"
  get "curriculum", to: "curriculum#overview"
  root :to  => "main#index"
end
