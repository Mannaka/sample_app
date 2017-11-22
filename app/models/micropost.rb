class Micropost < ActiveRecord::Base
    # マイクロポストがユーザーに所属する関連付け
    belongs_to :user
    default_scope -> {order('created_at DESC')}
#    validates :contents, presence: true, length: {maximum: 140}
    validates :content, presence: true, length: {maximum: 140}
    validates :user_id, presence: true
end
