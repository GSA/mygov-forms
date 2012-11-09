class FormField < ActiveRecord::Base
  belongs_to :form
  attr_accessible :field_type, :name, :label, :description, :is_required, :options, :multiple
  validates_presence_of :field_type, :name
  serialize :options
  
  def as_json(options = {})
    super(options.merge(:only => [:name, :field_type, :label, :description, :is_required, :multiple]).merge(:options => self.options.each{|k,v| {k: v}}))
  end
end