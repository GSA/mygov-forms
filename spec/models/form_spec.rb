require 'spec_helper'

describe Form do
  before do
    @valid_attributes = {
      :title => 'Form Title',
      :number => 'F-1',
      :start_content => 'Before you begin filling out the form, make sure that you have the following materials...',
      :agency_name => 'Test Government Agency',
      :published_at => Time.now
    }
  end

  it { should validate_presence_of :title }
  it { should validate_presence_of :number }
  it { should have_many :form_fields }
  it { should have_one :pdf }


  context "Valid form objects" do
    it "creates a valid object with valid attributes" do
      Form.create!(@valid_attributes).should be_valid
    end

    it "saves a default value for published_at when it has not been set" do
      @valid_attributes.delete(:published_at)
      new_form = Form.new(@valid_attributes)

      new_form.save
      expect(new_form.published_at).to_not be_nil
    end
  end


  context "Invalid form objects" do
    [:number, :title, :start_content, :agency_name].each do |attr|
      it "should not be valid with a missing '#{attr}'' attribute" do
        form = Form.new(@valid_attributes)
        form.send("#{attr.to_s}=", nil)
        form.should_not be_valid
      end
    end
  end




  context "when the form has form fields, so with field orders, some without" do
    before do
      @form = Form.create!(@valid_attributes)
      @form.form_fields.create!(:field_type => "string", :name => "Unordered field 1")
      @form.form_fields.create!(:field_type => "string", :name => "Unordered field 2")
      @form.form_fields.create!(:field_type => "string", :name => "Field 2", :position => 2)
      @form.form_fields.create!(:field_type => "string", :name => "Field 1", :position => 1)
    end

    it "returns the fields in order, with unordered fields last, sorted by id asc" do
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

    it "outputs JSON with the number and title" do
      expect(JSON.parse(@form.to_json)).to eq({"icr_reference_number"=>nil, "number"=>"F-1", "omb_control_number"=>nil, "omb_expiration_date"=>nil, "title"=>"Form Title"})
    end
  end
end
