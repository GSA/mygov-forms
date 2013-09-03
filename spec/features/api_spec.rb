require 'spec_helper'

describe "API", :type => :request do
  before {create_sample_forms}

  describe "GET /api/forms" do
    it "returns a JSON list of all the forms" do
      get "/api/forms"
      parsed_json = JSON.parse(response.body)

      expect(response.code).to eq "200"
      expect(parsed_json.first).to eq(JSON.parse({icr_reference_number: "201305-4040-001", number: "S-1", omb_control_number: "4040-0001", omb_expiration_date: "2016-06-30", title: "Sample Form 1"}.to_json))
      expect(parsed_json.last).to eq({"icr_reference_number"=>"123456-1111-001", "number"=>"S-2", "omb_control_number"=>"4040-0001", "omb_expiration_date"=>nil, "title"=>"Sample Form 2"})
    end
  end

  describe "GET /api/forms/:id" do
    context "when a form exists for the id supplied" do
      context "when a form contains a form_field of type select" do
        it "should return a JSON representation of the form and all its fields" do
          get "/api/forms/#{@sample_form_1.to_param}"
          parsed_json = JSON.parse(response.body)

          expect(response.code).to eq "200"
          expect(parsed_json["title"]).to eq "Sample Form 1"
          expect(parsed_json["icr_reference_number"]).to eq "201305-4040-001"
          expect(parsed_json["number"]).to eq "S-1"
          expect(parsed_json["omb_control_number"]).to eq "4040-0001"
          expect(parsed_json["omb_expiration_date"]).to eq('2016-06-30')
          expect(parsed_json["form_fields"].size).to eq 3
          expect(parsed_json["form_fields"].first["field_type"]).to eq "text"
          expect(parsed_json['form_fields'].last["options"]).to eq [["Yes", "Yes"], ["No", "No"]]
        end
      end

      context "when a form does not contain a form_field of type select" do
        it "does not contain an array of options in the JSON representation of the form" do
          get "/api/forms/#{@sample_form_2.to_param}"
          parsed_json = JSON.parse(response.body)
          @options_hash = false
          parsed_json["form_fields"].map {|form_field| @options_hash = true if form_field.has_key?("options") }

          expect(@options_hash).to be false
        end
      end

    end

    context "when the id does not exist" do
      it "should return an error and a 404 status" do
        get "/api/forms/456765"
        parsed_json = JSON.parse(response.body)

        expect(response.code).to eq "404"
        expect(parsed_json["status"]).to eq "Error"
        expect(parsed_json["message"]).to eq "Form with id=456765 not found"
      end
    end
  end

  describe "GET /api/forms/:form_id/submissions/:id" do
    context "when the form id is invalid" do
      it "should return an error" do
        get "/api/forms/bad_form_id/submissions/123"
        parsed_json = JSON.parse(response.body)

        expect(response.code).to eq "404"
        expect(parsed_json["status"]).to eq "Error"
        expect(parsed_json["message"]).to eq "Invalid form number."
      end
    end

    context "when the submission id is invalid" do
      it "should return an error" do
        get "/api/forms/#{@sample_form_1.to_param}/submissions/123"
        parsed_json = JSON.parse(response.body)

        expect(response.code).to eq "404"
        expect(parsed_json["status"]).to eq "Error"
      end
    end

    context "when the submission id is valid" do
      before do
        @submission = @sample_form_1.submissions.create!(:data => {:text_field => "Test"})
      end

      it "should return the submission" do
        get "/api/forms/#{@sample_form_1.to_param}/submissions/#{@submission.to_param}"
        parsed_json = JSON.parse(response.body)

        expect(response.code).to eq "200"
        expect(parsed_json["guid"]).to eq @submission.guid
        expect(parsed_json["data"]).to eq @submission.data.stringify_keys
      end
    end
  end

  describe "POST /api/forms/:form_id/submissions" do
    context "when valid form information is submitted" do
      it "should save the form as a submission" do
        post "/api/forms/#{@sample_form_1.to_param}/submissions", {:submission => {:data => {:text_field => 'Test'}}}
        parsed_json = JSON.parse(response.body)

        expect(response.code).to eq "201"
        expect(parsed_json["guid"]).not_to be_nil
        expect(parsed_json["guid"].size).to eq 40
        expect(Submission.last.data[:text_field]).to eq "Test"
        expect(Submission.last.data[:select_field]).to be_blank
      end
    end

    context "when no form id is submitted" do
      it "should return an error message" do
        post "/api/forms/bad_form_id/submissions", {:submission => {:data => {:text_field => 'Test'}}}
        parsed_json = JSON.parse(response.body)

        expect(response.code).to eq "406"
        expect(parsed_json["status"]).to eq "Error"
        expect(parsed_json["message"]).to eq "Form submission invalid: missing valid form id"
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
        parsed_json = JSON.parse(response.body)

        expect(response.code).to eq "404"
        expect(parsed_json["status"]).to eq "Error"
        expect(parsed_json["message"]).to eq "Form with number: ss-5 not found."
      end
    end

    context "when the number matches a form, but the form does not have a PDF associated with it" do
      it "should return an error" do
        post "/api/forms/s-2/fill_pdf"
        parsed_json = JSON.parse(response.body)

        expect(response.code).to eq "404"
        expect(parsed_json["status"]).to eq "Error"
        expect(parsed_json["message"]).to eq "No PDF associated with that form."
      end
    end

    context "when the number matches a form, and everything works out fine" do
      context "when the PDF filling works" do
        before do
          Pdf.any_instance.stub(:fill_in).and_return "THIS IS A FAKE PDF"
        end

        it "should return a filled in PDF" do
          post "/api/forms/#{@sample_form_1.to_param}/fill_pdf", {:data => {}}

          expect(response.code).to eq "200"
          expect(response.body).to eq "THIS IS A FAKE PDF"
          expect(response.content_type).to eq "application/pdf"
          expect(response.header["Content-Disposition"]).to match /filename=\"test\.pdf/
        end
      end

      context "when the PDF filling does not work" do
        before do
          Pdf.any_instance.stub(:fill_in).and_raise "Error filling PDF"
        end

        it "should return an error" do
          post "/api/forms/#{@sample_form_1.to_param}/fill_pdf", {:data => {}}
          parsed_json = JSON.parse(response.body)

          expect(response.code).to eq "500"
          expect(parsed_json["status"]).to eq "Error"
          expect(parsed_json["message"]).to eq "Error filling PDF"
        end
      end
    end
  end
end