class PdfField < ActiveRecord::Base
  belongs_to :pdf
  belongs_to :form_field
  attr_accessible :name, :page_number, :x, :y

  def is_fillable?
    self.name.present?
  end  
end
