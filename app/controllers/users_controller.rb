class UsersController < ApplicationController
  before_action :authenticate_user!, :except=>[:show]
  # 管理者のみ削除を行えるようにする
  before_action :admin_user,  only: :destroy

  def index
    @users = User.paginate(page: params[:page])
  end
  
  def show
        @user = User.find(params[:id])
        #投稿したマイクロポストをそのページに表示する分取得
        @microposts = @user.microposts.paginate(page: params[:page])
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
  end

  def following
    #タイトル設定
    @title = "Following"
    #ユーザー検索
    @user = User.find(params[:id])
    #データの所得およびページネーション
    @users = @user.followed_users.paginate(page: params[:page])
    #controllerでのrenderはほかのアクションのテンプレートを丸々使いたいときに使用
    #この場合はshow_follow(view)を呼び出し  
    render 'show_follow'
  end
  
  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end
  
  private
  
  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end

end
