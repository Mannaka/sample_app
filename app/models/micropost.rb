class Micropost < ActiveRecord::Base
    # マイクロポストがユーザーに所属する関連付け
    belongs_to :user
    default_scope -> {order('created_at DESC')}
#    validates :contents, presence: true, length: {maximum: 140}
    validates :content, presence: true, length: {maximum: 140}
    validates :user_id, presence: true
    
    # フォローしているユーザーのidの配列を取得する
    def self.from_users_followed_by(user)
        
        #↓これでも取れるがDBにアクセスしてしまう
        #followed_user_ids = user.followed_user_ids
        
        #SQL文だけ先に作成しておく
        followed_user_ids = "SELECT followed_id FROM relationships
                                  WHERE follower_id = :user_id"
        
        #where("user_id IN (?) OR user_id = ?" , followed_user_ids ,user)
        
        #↑「？」でも取得できるが、複数の同じ条件に挿入する場合
        #挿入場所に名前を付けて値を指定する↓(followed_user_ids)の方が
        #便利で間違いが起きにくい
        
        where("user_id IN (#{followed_user_ids}) OR user_id = :user_id",
            user_id: user.id)
    end
end
