require 'spec_helper'

describe "Forms" do
  describe "GET /" do
      it "should show the home page" do
        visit root_path
        page.should have_content "All Forms"
      end
    
    context "when there are forms in the database" do
      before do
        @sample_form_1 = Form.create!(:title => 'Sample Form 1', :number => 'S-1')
        sample_form_2 = Form.create!(:title => 'Sample Form 2', :number => 'S-2')
        
        @sample_form_1.form_fields.create!(:field_type => "text", :name => 'text_field', :label => 'A Text Field', :description => 'This is a text field.')
        @sample_form_1.form_fields.create!(:field_type => "date", :name => 'date_field', :label => 'A Date Field', :description => 'This is a date field.')
        @sample_form_1.form_fields.create!(:field_type => "select", :name => 'select_field', :label => 'A Select Field', :description => 'This is a select field', :options => [['Yes', 'Yes'], ['No', 'No']])
      end
      
      it "should list the forms on the home page and link to those forms by title and number" do
        visit root_path
        page.should have_link 'Sample Form 1 (S-1)'
        page.should have_link 'Sample Form 2 (S-2)'
      end
      
      it "should let a user navigate to a form and fill it out" do
        visit root_path
        click_link 'Sample Form 1 (S-1)'
        page.should have_content "A Text Field"
        page.should have_content "A Date Field"
        page.should have_content "A Select Field"
        fill_in 'A Text Field', :with => 'America'
        click_button "Submit"
        page.should have_content "Your form has been submitted"
        page.should have_no_button "Download as PDF"
        Submission.last.data[:text_field].should == "America"
        Submission.last.data[:select_field].should be_blank
      end
      
      context "when the form has a PDF associated with it" do
        before do
          pdf = @sample_form_1.build_pdf(:url => "http://example.gov/form.pdf")
          pdf.save!
          pdf_field = pdf.pdf_fields.create!(:name => 'text_field')
          pdf_field.form_field = @sample_form_1.form_fields.first
          pdf_field.save!
        end
        
        it "should allow the user to download a PDF version of their form if available" do
          visit root_path
          click_link 'Sample Form 1 (S-1)'
          fill_in 'A Text Field', :with => 'America'
          click_button "Submit"
          page.should have_link "Download as PDF"
        end
      end
    end
  end
end
