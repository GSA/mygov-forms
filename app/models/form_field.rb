class FormField < ActiveRecord::Base
  belongs_to :form
  attr_accessible :field_type, :name
  validates_presence_of :field_type, :name
  
  def as_json(options = {})
    super(options.merge(:only => [:name, :field_type]))
  end
end
