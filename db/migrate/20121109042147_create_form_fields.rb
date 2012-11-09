class CreateFormFields < ActiveRecord::Migration
  def change
    create_table :form_fields do |t|
      t.string :name
      t.string :field_type
      t.references :form

      t.timestamps
    end
    add_index :form_fields, :form_id
  end
end
