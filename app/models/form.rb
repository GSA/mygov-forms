class Form < ActiveRecord::Base
  has_many :form_fields, :order => '-position DESC, id ASC', :dependent => :destroy
  has_one :pdf, :dependent => :destroy
  has_many :submissions, :dependent => :destroy
  attr_accessible :number, :title, :form_fields_attributes, :icr_reference_number, :omb_control_number, :omb_expiration_date, :options, :start_content, :agency_name, :published_at
  validates_presence_of :number, :title, :start_content, :agency_name, :published_at
  validates_uniqueness_of :number
  accepts_nested_attributes_for :form_fields, :reject_if => :all_blank, :allow_destroy => true

  before_validation :set_default_values

  def self.import_from_json(file)
    return if file.include?('pdf.json')
    print " importing #{file}."
    parsed_form_json = JSON.parse(File.read(file))
    
    form = Form.find_or_create_by_number(parsed_form_json["form"]["number"],
          :title => parsed_form_json["form"]["title"],
          :icr_reference_number => parsed_form_json["form"]["icr_reference_number"],
          :omb_control_number => parsed_form_json["form"]["omb_control_number"],
          :omb_expiration_date => parsed_form_json["form"]["omb_expiration_date"],
          :start_content => parsed_form_json["form"]["start_content"],
          :agency_name => parsed_form_json["form"]["agency_name"],
          :published_at => Time.now
          )
          
    form.pdf.destroy if form.pdf
    pdf = form.pdf = Pdf.import_from_json(file.gsub('.json', '.pdf.json'))

    form.form_fields.destroy_all

    parsed_form_json["form"]["form_fields"].each_with_index do |form_field, index|
      new_form_field = FormField.create(form_field.merge(:position => index + 1))

      pdf_field = pdf.pdf_fields.find_by_name(form_field['pdf_field']) if pdf
      new_form_field.pdf_fields << pdf_field if pdf_field
      
      form.form_fields << new_form_field
    end
    
    form
  end

  def as_json(options = {})
    super(options.merge(:only => [:number, :title, :icr_reference_number, :omb_control_number, :omb_expiration_date]))
  end

  def to_param
    self.number.parameterize
  end

  def set_default_values
    self.published_at = Time.now if published_at.nil?
  end
end
``