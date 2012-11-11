class Form < ActiveRecord::Base
  has_many :form_fields
  has_one :pdf
  attr_accessible :number, :title
  validates_presence_of :number, :title
  validates_uniqueness_of :number
  
  def as_json(options = {})
    super(options.merge(:only => [:id, :number, :title]))
  end
end
