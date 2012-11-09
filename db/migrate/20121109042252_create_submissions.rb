class CreateSubmissions < ActiveRecord::Migration
  def change
    create_table :submissions do |t|
      t.references :form
      t.text :data

      t.timestamps
    end
    add_index :submissions, :form_id
  end
end
