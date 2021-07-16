class CreateCompanies < ActiveRecord::Migration[6.0]
  def change
    create_table :companies do |t|
      t.string :name, unique: true
      t.string :short_name, null: false
      t.string :description, null: false
      t.string :logo_url, null: false
      t.string :address, null: false
      t.string :contact_phone, null: false
      t.string :background_img_url, null: false
      t.boolean :is_branch, default: false

      t.timestamps
    end

    add_index :companies, :name, unique: true
  end
end
