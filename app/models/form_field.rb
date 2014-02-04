class FormField < ActiveRecord::Base
  belongs_to :form
  has_many :pdf_fields
  attr_accessible :field_type, :name, :label, :description, :is_required, :options, :multiple, :pdf_field, :position
  validates_presence_of :field_type, :name
  serialize :options
  
  def as_json(options = {})
    super_options = options.merge(:only => [:name, :field_type, :label, :description, :is_required, :multiple, :position])
    super_options[:only] << :options if self.options
    super(super_options)
  end
  
  def formtastic_field_type
    case self.field_type
    when "date"
      "date_picker"
    when "date_select"
      "date_picker"
    when "time"
      "time_select"
    when "datetime"
      "datetime_select"
    else
      self.field_type
    end
  end
end