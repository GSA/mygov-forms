class AddContentToForms < ActiveRecord::Migration
  def change
    add_column :forms, :start_content, :text
    add_column :forms, :need_to_know_content, :text
    add_column :forms, :ways_to_apply_content, :text
  end
end
