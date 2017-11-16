class CreateMicroposts < ActiveRecord::Migration
  def change
    create_table :microposts do |t|
      t.string :content
      t.integer :user_id

      t.timestamps null: false
    end
    # user_id に関連付けされたすべてのマイクロポストを作成時刻の逆順で取り出す
    add_index :microposts, [:user_id, :created_at]
  end
end
