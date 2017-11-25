class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.integer :follower_id
      t.integer :followed_id

      t.timestamps null: false
    end
    add_index :relationships, :follower_id
    add_index :relationships, :followed_id
    # 複合インデックスでユニークに指定　フォロワーとフォローされた組み合わせの一意性を保証
    add_index :relationships, [:follower_id, :followed_id], unique: true
    
  end
end
