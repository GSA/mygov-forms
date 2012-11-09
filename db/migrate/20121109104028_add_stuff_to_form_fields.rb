class AddStuffToFormFields < ActiveRecord::Migration
  def change
    add_column :form_fields, :label, :string
    add_column :form_fields, :description, :text
    add_column :form_fields, :is_required, :boolean, :default => false
    add_column :form_fields, :options, :text
    add_column :form_fields, :multiple, :boolean, :default => false
  end
end
