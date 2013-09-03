require 'spec_helper'

describe Pdf do
  it { should belong_to :form }
  it { should have_many :pdf_fields }
  it { should validate_presence_of :url }

  describe "#fill_in" do
    before do
      form = FactoryGirl.create(:form)
      @pdf = Pdf.new(:url => 'http://example.gov/sf-1.pdf')
      @pdf.form = form
      @pdf.save!
    end

    context "when the data passed in is nil" do
      before do
        stub_request(:post, "http://localhost:4567/fill").to_return(:status => 200, :body => "", :headers => {})
      end

      it "should not fail" do
        lambda { @pdf.fill_in(nil) }.should_not raise_error
      end
    end
  end
end
