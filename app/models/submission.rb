class Submission < ActiveRecord::Base
  belongs_to :form
  attr_accessible :data, :guid
  validates_presence_of :form_id, :guid
  validates_uniqueness_of :guid
  serialize :data
  before_validation :generate_guid
  
  def to_pdf
    data = {}
    self.data.each do |key, value|
      form_field = self.form.form_fields.find_by_name(key)
      if form_field and form_field.pdf_field
        data[form_field.pdf_field.name] = value if form_field.pdf_field.is_fillable?
        data["#{form_field.pdf_field.x},#{form_field.pdf_field.y},#{form_field.pdf_field.page_number}"] = value if !form_field.pdf_field.is_fillable?
      end
    end
    self.form.pdf.fill_in(data)
  end
  
  def to_param
    self.guid
  end
  
  private
  
  def generate_guid
    self.guid = SecureRandom.urlsafe_base64(30)
  end
end
