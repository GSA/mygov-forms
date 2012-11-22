class AddGuidToSubmission < ActiveRecord::Migration
  def change
    add_column :submissions, :guid, :string, :limit => 40
    add_index :submissions, :guid
  end
end
