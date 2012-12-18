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
  
  it "should create a new object with valid attributes" do
    Form.create!(@valid_attributes)
  end
  
  context "when the form has form fields, so with field orders, some without" do
    before do
      @form = Form.create!(@valid_attributes)
      @form.form_fields.create!(:field_type => "string", :name => "Unordered field 1")
      @form.form_fields.create!(:field_type => "string", :name => "Unordered field 2")
      @form.form_fields.create!(:field_type => "string", :name => "Field 2", :position => 2)
      @form.form_fields.create!(:field_type => "string", :name => "Field 1", :position => 1)
    end
    
    it "should return the fields in order, with unordered fields last, sorted by id asc" do
      fields = @form.form_fields
      fields.first.name.should == "Field 1"
      fields[1].name.should == "Field 2"
      fields[2].name.should == "Unordered field 1"
      fields.last.name.should == "Unordered field 2"
    end
  end
  
  describe "#to_json" do
    before do
      @form = Form.create!(@valid_attributes)
    end
    
    it "should output JSON with the number and title" do
      JSON.parse(@form.to_json).should == {"title" => 'Form Title', "number" => "F-1"}
    end
  end
end
