class FormField < ActiveRecord::Base
  belongs_to :form
  has_one :pdf_field
  attr_accessible :field_type, :name, :label, :description, :is_required, :options, :multiple
  validates_presence_of :field_type, :name
  serialize :options
  
  def as_json(options = {})
    super_options = options.merge(:only => [:name, :field_type, :label, :description, :is_required, :multiple])
    super_options.merge!(:options => self.options.each{|k,v| {k: v}}) if self.options.present?
    super(super_options)
  end
end