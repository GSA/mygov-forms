class PdfField < ActiveRecord::Base
  belongs_to :pdf
  belongs_to :form_field
  attr_accessible :field_state, :field_type, :label, :name, :page_number, :x, :y

  def is_fillable?
    self.name.present?
  end
end
