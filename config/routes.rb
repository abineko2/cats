Rails.application.routes.draw do
 

  get 'sessions/new'
  get 'auth/:provider/callback', to: 'sessions#create2'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy2', as: 'signout'
  get '/auth/:provider/callback',    to: 'users#facebook_login',      as: :auth_callback
  root "tops#show"  

                                                                #root
  get '/signup',to: 'users#new'                                                   #会員登録
  
  resources :users do                                                             #ユーザーカラム一式
     resources :posts,only:[:new,:create,:destroy]                    
  end
 
  get 'show_image/:id',to:'users#show_image',as: :show_image                      #イメージ表示
  get    '/login', to: 'sessions#new'                                             #ログインページへ                       
  post   '/login', to: 'sessions#create'                                          #ログイン処理
  delete '/logout', to: 'sessions#destroy'                                        #ログアウト処理
  
  get 'posts',to:'posts#index'                                                    #投稿一覧
  post 'posts',to:'posts#index'   
  get 'newPosts',to: 'posts#new',        as: :new_posts                           #新規投稿
  get 'post_edit/:id',to:'posts#post_edit',as:  :post_edit                        #投稿編集モーダル
  patch 'post_update/:id',to:'posts#post_update', as: :post_update                #モダール編集アップデート
  
  get 'posts/:id/message_show',to:'messages#show',  as: :messages_show            #投稿へのメッセージページへ
  post 'posts/:id/message_create',to:'messages#show',  as: :messages_create       #投稿へのメッセージ登録する
  get 'messege/edit/:msg_id',to:"messages#edit",as: :edit                         #メッセージの編集モーダル
  patch 'messege/update/:msg_id',to:"messages#update",as: :update                 #メッセージの編集アップデート
  delete 'message/delete/:msg_id',to: 'messages#destroy' , as: :delete            #メッセージの削除
  
  get 'replay/show_modal/:msg_id',to:'messages#replay_show',  as: :replay_show    #返信用モーダル
  post 'replay/create/:msg_id',to:"messages#replay_create",   as: :replay_create  #返信登録 
  get 'cats_new/:id',to:"users#cat_new",                      as: :cat_new        #猫新規登録ページ
  post 'cat_create/:user_id',to:'users#cat_create',           as: :cat_create     #猫新規登録
  patch 'cat_update/:id',to:'users#cat_update',               as: :cat_update
  get 'cat_show_image/:id',to:'users#cat_show_image',         as: :cat_show_image #猫写真アクセス
  get 'cat_modal/:id',to:'users#cat_modal',                   as: :cat_modal      #猫詳細
  delete 'cat_delete/:id',to:'users#cat_delete',              as: :cat_delete     #猫データ削除
  get 'cat_edit/:id',to:"users#cat_edit",                      as: :cat_edit      #猫編集モーダル
  get 'cat_plan/:id',to:'users#cat_plan',                     as:  :cat_plan      #猫スケジュールモーダル
  get 'cats/:id/plan_show/:user_id',to:'schedules#show',       as:  :plan_show     #各猫スケジュール
  post 'cats/plan_create',to:'schedules#create',                as:  :plan_create  #スケジュール登録
  patch 'cats/plan_update',to:'schedules#update',             as:  :plan_update   #スケジュールupdate
  delete 'cat/plan_delete/:id',to:'schedules#destroy',         as:  :plan_delete   #スケジュール削除
  get 'record_show',to:"records#show",                         as:  :record        #健康チェックtop
  post 'record_show',to:'records#show'                                             #健康チェック猫選択
  post 'result_view',to:'records#result_view',                as: :result_view      #猫体重ページ表示
  get 'result_view',to:'records#result_view'                                        #猫体重ページ表示
  post 'result_create',to:'records#create',                   as: :result_create    #猫体重登録
end

