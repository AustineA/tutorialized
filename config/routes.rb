Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  defaults format: "json" do
    post "user_token" => "user_token#create"

    resources :users, only: [:update, :index, :show, :destroy]
    post "register", to: "users#create"
    post "users/iforgot", to: "users#iforgot"
    post "users/change-password", to: "users#change_password"

    root "courses#index"
  end
end
