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
      parsed_json.first.should == {"title" => "Sample Form 1", "number" => 'S-1'}
      parsed_json.last.should == {"title" => "Sample Form 2", "number" => 'S-2'}
    end
  end
  
  describe "GET /api/forms/:id" do
    context "when a form exists for the id supplied" do
      it "should return a JSON representation of the form and all its fields" do
        get "/api/forms/#{@sample_form_1.to_param}"
        response.code.should == "200"
        parsed_json = JSON.parse(response.body)
        parsed_json["title"].should == "Sample Form 1"
        parsed_json["form_fields"].size.should == 3
        parsed_json["form_fields"].first["field_type"].should == "text"
      end
    end
    
    context "when the id does not exist" do
      it "should return an error and a 404 status" do
        get "/api/forms/456765"
        response.code.should == "404"
        parsed_json = JSON.parse(response.body)
        parsed_json["status"].should == "Error"
        parsed_json["message"].should == "Form with id=456765 not found"
      end
    end
  end
  
  describe "GET /api/forms/:form_id/submissions/:id" do
    context "when the form id is invalid" do
      it "should return an error" do
        get "/api/forms/bad_form_id/submissions/123"
        response.code.should == "404"
        parsed_json = JSON.parse(response.body)
        parsed_json["status"].should == "Error"
        parsed_json["message"].should == "Invalid form number."
      end
    end
    
    context "when the submission id is invalid" do
      it "should return an error" do
        get "/api/forms/#{@sample_form_1.to_param}/submissions/123"
        response.code.should == "404"
        parsed_json = JSON.parse(response.body)
        parsed_json["status"].should == "Error"
      end
    end
    
    context "when the submission id is valid" do
      before do
        @submission = @sample_form_1.submissions.create!(:data => {:text_field => "Test"})
      end
      
      it "should return the submission" do
        get "/api/forms/#{@sample_form_1.to_param}/submissions/#{@submission.to_param}"
        response.code.should == "200"
        parsed_json = JSON.parse(response.body)
        parsed_json["guid"].should == @submission.guid
        parsed_json["data"].should == @submission.data.stringify_keys
      end
    end
  end
             
  describe "POST /api/forms/:form_id/submissions" do
    context "when valid form information is submitted" do
      it "should save the form as a submission" do
        post "/api/forms/#{@sample_form_1.to_param}/submissions", {:submission => {:data => {:text_field => 'Test'}}}
        response.code.should == "201"
        parsed_json = JSON.parse(response.body)
        parsed_json["guid"].should_not be_nil
        parsed_json["guid"].size.should == 40
        Submission.last.data[:text_field].should == "Test"
        Submission.last.data[:select_field].should be_blank
      end
    end
    
    context "when no form id is submitted" do
      it "should return an error message" do
        post "/api/forms/bad_form_id/submissions", {:submission => {:data => {:text_field => 'Test'}}}
        response.code.should == "406"
        parsed_json = JSON.parse(response.body)
        parsed_json["status"].should == "Error"
        parsed_json["message"].should == "Form submission invalid: missing valid form id"
      end
    end    
  end
  
  describe "POST /api/forms/:id/pdf/fill" do
    before do
      @pdf = Pdf.create!(:url => "http://example.gov/test.pdf")
      @pdf.form = @sample_form_1
      @pdf.save!
    end
    
    context "when the number provided does not match a form" do
      it "should return an error" do
        post "/api/forms/ss-5/fill_pdf"
        response.code.should == "404"
        parsed_json = JSON.parse(response.body)
        parsed_json["status"].should == "Error"
        parsed_json["message"].should == "Form with number: ss-5 not found."
      end
    end
    
    context "when the number matches a form, but the form does not have a PDF associated with it" do
      it "should return an error" do
        post "/api/forms/s-2/fill_pdf"
        response.code.should == "404"
        parsed_json = JSON.parse(response.body)
        parsed_json["status"] == "Error"
        parsed_json["message"] == "No PDF associated with that form."
      end
    end
    
    context "when the number matches a form, and everything works out fine" do
      context "when the PDF filling works" do
        before do
          Pdf.any_instance.stub(:fill_in).and_return "THIS IS A FAKE PDF"
        end
      
        it "should return a filled in PDF" do
          post "/api/forms/#{@sample_form_1.to_param}/fill_pdf", {:data => {}}
          response.code.should == "200"
          response.body.should == "THIS IS A FAKE PDF"
          response.content_type.should == "application/pdf"
          response.header["Content-Disposition"].should =~ /filename=\"test\.pdf/
        end
      end
      
      context "when the PDF filling does not work" do
        before do
          Pdf.any_instance.stub(:fill_in).and_raise "Error filling PDF"
        end
        
        it "should return an error" do
          post "/api/forms/#{@sample_form_1.to_param}/fill_pdf", {:data => {}}
          response.code.should == "500"
          parsed_json = JSON.parse(response.body)
          parsed_json["status"].should == "Error"
          parsed_json["message"].should == "Error filling PDF"
        end
      end
    end
  end 
end