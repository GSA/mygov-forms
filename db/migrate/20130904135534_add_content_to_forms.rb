class AddContentToForms < ActiveRecord::Migration
  def change
    add_column :forms, :description, :text
    add_column :forms, :start_content, :text
    add_column :forms, :need_to_know_content, :text
    add_column :forms, :ways_to_apply_content, :text
    add_column :forms, :agency_name, :string
    add_column :forms, :published_at, :datetime
  end
end
