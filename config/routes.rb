Rails.application.routes.draw do
  devise_for :users
  resources :teams do
    collection do
      get "/add_member/:id" => "teams#add_member", as: :add_member
      post "/create_member" => "teams#create_member"
      get "/members/:id" => "teams#team_members", as: :members
    end
  end

  root to: "teams#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
