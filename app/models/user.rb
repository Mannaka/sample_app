class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  
  #ユーザーがマイクロポストを複数所有する関連付け
  #マイクロポストはユーザーと一緒に破棄
  has_many :microposts, dependent: :destroy
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
    validates :name, presence: true
    validates :name,  presence: true, length: { maximum: 50 }
end
