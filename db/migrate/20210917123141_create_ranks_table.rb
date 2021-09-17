class CreateRanksTable < ActiveRecord::Migration[6.0]
  def change
    create_table :ratings do |t|
      t.integer :value, null: false

      t.timestamps
    end

    add_reference :ratings, :service
    add_reference :ratings, :user

    add_index :ratings, [:user_id, :service_id], name: 'index_user_id_service_id'
  end
end
