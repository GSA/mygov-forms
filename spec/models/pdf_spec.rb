require 'spec_helper'

describe Pdf do
  it { should belong_to :form }
  it { should have_many :pdf_fields }
  it { should validate_presence_of :url }
end
