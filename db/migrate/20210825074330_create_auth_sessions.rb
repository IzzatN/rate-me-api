class CreateAuthSessions < ActiveRecord::Migration[6.0]
  def change
    create_table :auth_sessions do |t|
      t.references :user, null: false

      t.string :token, null: false
      t.datetime :expires_at, null: false

      t.timestamps
    end

    add_index :auth_sessions, :expires_at

    add_index :auth_sessions, [:token, :expires_at]
    add_index :auth_sessions, [:user_id, :expires_at]
  end
end
