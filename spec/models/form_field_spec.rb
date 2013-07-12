require 'spec_helper'

describe FormField do
  before do
    @form = Form.create!(:title => "Form 1", :number => "F-1")
    @valid_attributes = {
      :field_type => "string",
      :name => "Field 1"
    }
  end
  
  it { should validate_presence_of :field_type }
  it { should validate_presence_of :name }
  it { should belong_to :form }
  it { should have_one :pdf_field }
  
  it "should create a new instance given valid attributes" do
    form_field = FormField.new(@valid_attributes)
    form_field.form = @form
    form_field.save!
  end
end
