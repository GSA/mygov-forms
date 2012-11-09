class FormField < ActiveRecord::Base
  belongs_to :form
  attr_accessible :field_type, :name
end
