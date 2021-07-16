class AddParentBranchFieldsToCompany < ActiveRecord::Migration[6.0]
  def change
    add_reference :companies, :parent, null: true
  end
end
