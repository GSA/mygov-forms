require 'spec_helper'

describe "API", :type => :request do
  before do
    @sample_form_1 = Form.create!(:title => 'Sample Form 1', :number => 'S-1')
    @sample_form_2 = Form.create!(:title => 'Sample Form 2', :number => 'S-2')
    
    @sample_form_1.form_fields.create!(:field_type => "text", :name => 'text_field', :label => 'A Text Field', :description => 'This is a text field.')
    @sample_form_1.form_fields.create!(:field_type => "date", :name => 'date_field', :label => 'A Date Field', :description => 'This is a date field.')
    @sample_form_1.form_fields.create!(:field_type => "select", :name => 'select_field', :label => 'A Select Field', :description => 'This is a select field', :options => [['Yes', 'Yes'], ['No', 'No']])
  end

  describe "GET /api/forms" do    
    it "should return a JSON list of all the forms" do
      get "/api/forms"
      response.code.should == "200"
      parsed_json = JSON.parse(response.body)
      parsed_json.first.should == {"id" => 1, "title" => "Sample Form 1", "number" => 'S-1'}
      parsed_json.last.should == {"id" => 2, "title" => "Sample Form 2", "number" => 'S-2'}
    end
  end
  
  describe "GET /api/forms/:id" do
    it "should return a JSON representation of the form and all its fields" do
      get "/api/forms/#{@sample_form_1.id}"
      response.code.should == "200"
      parsed_json = JSON.parse(response.body)
      parsed_json["title"].should == "Sample Form 1"
      parsed_json["form_fields"].size.should == 3
      parsed_json["form_fields"].first["field_type"].should == "text"
    end
  end
end