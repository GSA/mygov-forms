class AddOrderToFormFields < ActiveRecord::Migration
  def change
    add_column :form_fields, :position, :integer
    add_index :form_fields, [:form_id, :position]
  end
end
