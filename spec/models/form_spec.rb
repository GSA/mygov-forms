require 'spec_helper'

describe Form do
  before do
    @valid_attributes = {
      :title => 'Form Title',
      :number => 'F-1'
    }
  end
  
  it { should validate_presence_of :title }
  it { should validate_presence_of :number }
  it { should have_many :form_fields }
  it { should have_one :pdf }
end
