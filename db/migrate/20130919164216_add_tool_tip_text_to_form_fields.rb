class AddToolTipTextToFormFields < ActiveRecord::Migration
  def change
    add_column :form_fields, :tool_tip_text, :text
  end
end
