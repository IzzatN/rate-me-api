class CreateServiceCategoriesjoinTable < ActiveRecord::Migration[6.0]
  def change
    create_join_table :services, :categories, { table_name: :service_categories } do |t|
      t.index :service_id
      t.index :category_id
    end
  end
end
