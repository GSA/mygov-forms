class CreatePdfs < ActiveRecord::Migration
  def change
    create_table :pdfs do |t|
      t.string :url
      t.references :form

      t.timestamps
    end
    add_index :pdfs, :form_id
  end
end
