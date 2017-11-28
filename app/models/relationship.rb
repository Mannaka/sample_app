class Relationship < ActiveRecord::Base
    
    #follower および followed　に属するという関係⇒　belongs_to
    #Railsは外部キーの名前を対応するシンボルから推測する（followerと書くとfollower_idと
    #id付きタグを推測してしまうので、勝手に推測しないよう、クラス名Userを指定）
    #followed_idのみアクセス可能
    belongs_to :follower, class_name: "User"
    belongs_to :followed, class_name: "User"
    validates :follower_id, presence: true
    validates :followed_id, presence: true
end
