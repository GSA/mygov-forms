class AddOmbNumberAndExpirationDateToForms < ActiveRecord::Migration
  def change
    add_column :forms, :icr_reference_number, :string
    add_column :forms, :omb_control_number, :string
    add_column :forms, :omb_expiration_date, :date
  end
end
