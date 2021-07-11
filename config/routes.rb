Rails.application.routes.draw do
  resources :grupos do
    resources :tarefas
  end
end
