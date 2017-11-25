class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  
  #ユーザーがマイクロポストを複数所有する関連付け
  #dependent　マイクロポストはユーザーと一緒に破棄
  has_many :microposts, dependent: :destroy
  #ユーザー/リレーションシップのhas_manyの関連付け
  #dependent: :destroy ユーザーが削除されたときにリレーションシップも削除
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  
  has_many :followed_users, through: :relationships, source: :followed
  
  #フォロワーを取得（followed_usersの逆）
  #クラス名を指定する必要がある（しないとRailsがデフォルトでReverseRelationshipという
  #存在しないクラスを探しに行く
  has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name: "Relationship",
                                    dependent:  :destroy
  
  #followers はRailsが自動で単数形にした名前（Follower_id）という外部キーを見に行く
  has_many :followers, through: :reverse_relationships, source: :follower
  
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
    validates :name, presence: true
    validates :name,  presence: true, length: { maximum: 50 }

  def feed
    Micropost.where("user_id= ?" , id)
  end

  #ステータスをチェックするようなメソッドをモデルに実装して、
  #そのメソッドを外部で使うという方法はRailsの定石

  #指定したユーザーがフォロー済みかどうかチェック
  def following?(other_user)
    relationships.find_by(followed_id: other_user.id)
  end
  
  #ユーザーをフォローする関係性を簡単に作成できるようにする
  #通常の処理ではこれは失敗することは考えられないので、!で
  #例外を発生させる
  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by(followed_id: other_user.id).destroy
  end
end

