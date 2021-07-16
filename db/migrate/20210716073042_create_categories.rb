class CreateCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :categories do |t|
      t.string :name, null: false
      t.string :value, null: false
    end

    add_index :categories, :value, unique: true
  end
end
