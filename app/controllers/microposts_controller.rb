class MicropostsController < ApplicationController
   
   
    before_action :authenticate_user!
    #カレントユーザーが実際に指定のidのマイクロポストを持っているのかを
    #チェックする
    before_action :correct_user, only: :destroy
   
   
   
    def create
        @micropost = current_user.microposts.build(micropost_params)
        if @micropost.save
            flash[:success] = "Micropost created!"
            redirect_to root_url
        else
            #マイクロポスト投稿失敗時用に空の配列を用意
            @feed_items = []
            render 'static_pages/home'
        end
    end
    
    def destroy
        @micropost.destroy
        redirect_to root_url
    end
    
    private
        def micropost_params
            params.require(:micropost).permit(:content)
        end
        
        #マイクロポストを見つける際に現在のユーザーに紐づいているものを
        #関連付けを経由して取得
        def correct_user
            @micropost = current_user.microposts.find_by(id: params[:id])
            redirect_to root_url if @micropost.nil?
        end
end