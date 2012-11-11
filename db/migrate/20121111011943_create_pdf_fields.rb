class CreatePdfFields < ActiveRecord::Migration
  def change
    create_table :pdf_fields do |t|
      t.string :name
      t.integer :x
      t.integer :y
      t.integer :page_number
      t.references :pdf

      t.timestamps
    end
    add_index :pdf_fields, :pdf_id
  end
end
