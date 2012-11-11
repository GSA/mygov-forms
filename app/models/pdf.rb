class Pdf < ActiveRecord::Base
  belongs_to :form
  has_many :pdf_fields
  attr_accessible :url
  include HTTParty
  query_string_normalizer proc {|query|
    Array(query).map do |key, value|
      if value.nil?
        key.to_s
      else
        "#{URI.escape(key.to_s, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))}=#{URI.escape(value, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))}"
      end
    end.flatten.sort.join('&')
  }
        
  def fill_in(data)
    massaged_data = {}
    data.each do |key, value|
      massaged_key = URI.encode(key, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))
      massaged_data.merge!(massaged_key => URI.encode(data[key], Regexp.new("[^#{URI::PATTERN::UNRESERVED}]")))
    end
    body = {:pdf => self.url}.merge(massaged_data)
    pdf_response = self.class.post("http://localhost:4567/fill", {:body => body})
    if pdf_response.code == 200
      pdf_response.body
    else
      raise pdf_response.message
    end
  end
end
