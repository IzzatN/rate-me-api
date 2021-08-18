class AddServiceToComments < ActiveRecord::Migration[6.0]
  def change
    add_reference :comments, :service
  end
end
