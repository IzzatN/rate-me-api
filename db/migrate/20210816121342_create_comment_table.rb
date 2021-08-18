class CreateCommentTable < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.string :text, null: false
      t.references :user, null: false
      
      t.timestamps
    end
  end
end
