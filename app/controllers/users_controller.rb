class UsersController < ApplicationController
  before_action :set_user,only:[:show,:edit, :destroy, :show_image,:correct_user]
  before_action :logged_in_user, only: [:index,:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user,only: :destroy
  
  

  #ユーザー全表示ページネーション機能持ち
  def index 
    @users = User.paginate(page: params[:page],:per_page => 2)
  end

  def new                   #新規登ページ
    @user = User.new
    
  end
  
  def create                #新規登録
    @user = User.new(user_parameter)
    
    if @user.save
       log_in @user # 保存成功後、ログインします。
      flash[:success] = '登録しました。'
       redirect_to @user
    else
      render :new
    end  
  end

  def edit
  end

  def show
  end
  
  def update      #update
    @user = User.find(params[:id])
    if @user.update_attributes(user_parameter)
      flash[:success] = "情報更新しました。"
      redirect_to @user
    else
      render :edit      
    end
  end
#ユーザー削除
  def destroy
     @user.destroy
     flash[:success] = "オーナー情報#{@user.name}を削除しました。"
     redirect_to users_url
  end
 #画像バイナリー表示 
  def show_image  
    send_data @user.image
  end
private
   #個別ユーザー呼び出し
  def set_user                                                               
    @user = User.find(params[:id] )
  end
  
  def user_parameter     #ユーザーのpost patchパラメーター    rmasicで処理
     if params[:user][:image]
        params[:user][:image] = params[:user][:image].read
        image = params[:user][:image]
        rmagick_image = Magick::Image.from_blob(image).first
        rmagick_image.auto_orient!
        rmagick_image.strip!
        rmagick_image.write('public/make.jpg')
        params[:user][:image] = File.open('public/make.jpg').read
     elsif params[:user][:image].nil?
         params[:user][:image] = File.open('public/user.png').read 
     end
    params.require(:user).permit(:image, :name, :email, :password, :password_confirmation)
  end
   #==ログインされたユーザーかチェック
  def logged_in_user                       
      unless logged_in?
        store_location
        flash[:danger] = "ログインしてください。"
        redirect_to login_url
      end
  end
  #==アクセスユーザーとアクセス先のユーザーがあっているか?
  def correct_user
      redirect_to(root_url) unless current_user?(@user)
  end
  # システム管理権限所有かどうか判定します。
    def admin_user
      redirect_to root_url unless current_user.admin?
    end
end
