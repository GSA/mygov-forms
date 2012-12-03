class Pdf < ActiveRecord::Base
  belongs_to :form
  has_many :pdf_fields
  validates_presence_of :url
  attr_accessible :url
  URI_REGEX = Regexp.new("[^#{URI::PATTERN::UNRESERVED}]")
  
  include HTTParty
  query_string_normalizer proc {|query|
    Array(query).map do |key, value|
      if value.nil?
        key.to_s
      else
        "#{URI.escape(key.to_s, URI_REGEX)}=#{URI.escape(value, URI_REGEX)}"
      end
    end.flatten.sort.join('&')
  }
  
  # Takes form data, transforms to PDF fields, and then submits to PDF Filler to fill in.
  def fill_in(data)
    massaged_data = {}
    data.each do |key, value|
      form_field = self.form.form_fields.find_by_name(key)
      if form_field and form_field.pdf_field
        massaged_data[URI.encode(form_field.pdf_field.name, URI_REGEX)] = URI.encode(value, URI_REGEX) if form_field.pdf_field.is_fillable?
        massaged_data["#{form_field.pdf_field.x},#{form_field.pdf_field.y},#{form_field.pdf_field.page_number}"] = URI.encode(value, URI_REGEX) if !form_field.pdf_field.is_fillable?
      end
    end if data
    body = {:pdf => self.url}.merge(massaged_data)
    pdf_response = self.class.post(PDF_FILLER_FILL_URL, {:body => body})
    if pdf_response.code == 200
      pdf_response.body
    else
      raise pdf_response.message
    end
  end
end
