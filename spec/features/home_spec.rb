require 'spec_helper'

describe "Home", :type => :request do
  before do
    @sample_form_1 = Form.create!(:title => 'Sample Form 1', :number => 'S-1')
    @sample_form_2 = Form.create!(:title => 'Sample Form 2', :number => 'S-2')

    @sample_form_1.form_fields.create!(:field_type => "text", :name => 'text_field', :label => 'A Text Field', :description => 'This is a text field.')
    @sample_form_1.form_fields.create!(:field_type => "date", :name => 'date_field', :label => 'A Date Field', :description => 'This is a date field.')
    @sample_form_1.form_fields.create!(:field_type => "select", :name => 'select_field', :label => 'A Select Field', :description => 'This is a select field', :options => [['Yes', 'Yes'], ['No', 'No']])
  end

  describe "GET /" do
    it "should return a list of all the forms" do
      visit root_path
      page.should have_content("Sample Form 1")
      page.should have_content("Sample Form 2")
    end

    it "should have a link to log in" do
      visit root_path
      page.should have_content("Login")
    end
    
    it "sets secure headers (X-Frame-Options & X-XSS-Protection)" do
      # NOTE: the app also sets X-Content-Type-Options: nosniff, but that is only set for IE browsers
      visit root_path

      expect(page.response_headers["X-Frame-Options"]).to eq "SAMEORIGIN"
      expect(page.response_headers["X-XSS-Protection"]).to eq "1; mode=block"
    end
  end
end
