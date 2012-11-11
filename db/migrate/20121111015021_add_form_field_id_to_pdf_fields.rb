class AddFormFieldIdToPdfFields < ActiveRecord::Migration
  def change
    add_column :pdf_fields, :form_field_id, :integer
    add_index :pdf_fields, :form_field_id
  end
end
