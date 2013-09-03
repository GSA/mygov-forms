require 'spec_helper'

describe FormField do
  before do
    @form = FactoryGirl.create(:form)
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

  [:field_type, :name].each do |attr|
    it "should not be valid with missing attribute #{attr}" do
      form_field = FormField.new(@valid_attributes)
      form_field.form = @form
      form_field.send("#{attr.to_s}=", nil)
      form_field.should_not be_valid
    end
  end
end
