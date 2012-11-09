class CreateAgencies < ActiveRecord::Migration
  def change
    create_table :agencies do |t|
      t.string :name
      t.string :abbreviation

      t.timestamps
    end
  end
end
