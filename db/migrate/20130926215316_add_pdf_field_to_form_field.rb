class AddPdfFieldToFormField < ActiveRecord::Migration
  def change
    add_column :form_fields, :pdf_field, :string
  end
end
