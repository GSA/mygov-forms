require 'spec_helper'

describe FormField do
  
  it { should validate_presence_of :field_type }
  it { should validate_presence_of :name }
  it { should belong_to :form }
  it { should have_one :pdf_field }
end
