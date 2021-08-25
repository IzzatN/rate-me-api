class AddPasswordDigestAndRegisteredToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :password_digest, :text
    add_column :users, :is_registered, :boolean, default: false
  end
end
