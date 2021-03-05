Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "items#index"
  resources :items do               #>>>>>>>>>>>> づまずいた部分 ※購入画面で利用するためネストさせている  覚書きのためコメント削除しません
    resources :orders, only: [:index, :new, :create]  
  end

end
