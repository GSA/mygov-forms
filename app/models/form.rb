class Form < ActiveRecord::Base
  has_many :form_fields, :order => '-position DESC, id ASC'
  has_one :pdf
  has_many :submissions
  attr_accessible :number, :title, :form_fields_attributes, :icr_reference_number, :omb_control_number, :omb_expiration_date, :options, :start_content, :agency_name, :published_at
  validates_presence_of :number, :title, :start_content, :agency_name, :published_at
  validates_uniqueness_of :number
  accepts_nested_attributes_for :form_fields, :reject_if => :all_blank, :allow_destroy => true

  before_validation :set_default_values

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
