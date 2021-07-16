class CreateUser < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :uuid, unique: true
      t.string :token, unique: true
      t.string :email, unique: true
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :phone, null: false
      t.string :photoUrl, null: false
      t.boolean :is_consumer, default: false

      t.timestamps
    end

    add_index :users, :uuid, unique: true
    add_index :users, :email, unique: true
    add_index :users, :token, unique: true
  end
end
