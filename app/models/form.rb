class Form < ActiveRecord::Base
  has_many :form_fields
  attr_accessible :number, :title
end
