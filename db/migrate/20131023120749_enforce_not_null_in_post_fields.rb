class EnforceNotNullInPostFields < ActiveRecord::Migration
  def up
    change_column :posts, :title, :string, null: false
    change_column :posts, :body, :text, null: false
    change_column :posts, :topic_id, :integer, null: false
    change_column :posts, :user_id, :integer, null: false
  end

  def down
    change_column :posts, :user_id, :integer, null: true
    change_column :posts, :topic_id, :integer, null: true
    change_column :posts, :body, :text, null: true
    change_column :posts, :title, :string, null: true
  end
end
