Rails.application.routes.draw do
  
  # 顧客用
# URL /customers/sign_in ...
devise_for :users,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

# ユーザー
  scope module: :public do
  # homes
    root to: "homes#top"
  # users
    resources :users, only: [:index, :show, :update, :edit]
    get "/users/unsubscribe"=>"users#unsubscribe",as: 'unsubscribe'
    patch "/users/withdraw"=>"users#withdraw"
    get"/users/my_page"=>"users#my_page",as: 'my_page'
  # posts
    resources :posts, only: [:new, :index, :show, :create, :edit, :update, :destroy]
  # reports
    resources :reports, only: [:new, :create]
  # comments 
    resources :comments, only: [:index, :create, :destroy]
  # relationships 
    resources :relationships, only: [:create, :destroy, :following, :follower]
  # bookmarks
    resources :bookmarks, only: [:index, :create, :destroy]
  end  

  namespace :admin do
  # posts 
    resources :posts, only: [:index, :show, :destroy]
  # users
    resources :users, only: [:index, :show, :edit, :update]
  # tags 
    resources :tags, only: [:index, :create, :destroy]
  # reports
    resources :reports, only: [:index, :show, :update]
  end
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
