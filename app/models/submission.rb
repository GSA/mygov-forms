class Submission < ActiveRecord::Base
  belongs_to :form
  attr_accessible :data, :guid
  validates_presence_of :form_id, :guid
  validates_uniqueness_of :guid
  serialize :data
  before_validation :generate_guid
  
  def to_pdf
    self.form.pdf.fill_in(self.data)
  end
  
  def to_param
    self.guid
  end
  
  private
  
  def generate_guid
    self.guid = SecureRandom.urlsafe_base64(30)
  end
end
