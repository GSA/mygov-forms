class AddOptionsToPdfField < ActiveRecord::Migration
  def change
    add_column :pdf_fields, :field_state, :string
    add_column :pdf_fields, :field_type, :string
    add_column :pdf_fields, :label, :string
  end
end
