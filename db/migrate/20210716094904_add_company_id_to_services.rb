class AddCompanyIdToServices < ActiveRecord::Migration[6.0]
  def change
    add_reference :services, :company
  end
end
