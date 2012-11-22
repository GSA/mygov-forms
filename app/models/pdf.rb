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
  
  def fill_in(data)
    massaged_data = {}
    data.each do |key, value|
      massaged_key = URI.encode(key, URI_REGEX)
      massaged_data.merge!(massaged_key => URI.encode(data[key], URI_REGEX))
    end
    body = {:pdf => self.url}.merge(massaged_data)
    pdf_response = self.class.post(PDF_FILLER_FILL_URL, {:body => body})
    if pdf_response.code == 200
      pdf_response.body
    else
      raise pdf_response.message
    end
  end
end