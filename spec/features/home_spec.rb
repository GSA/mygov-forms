require 'spec_helper'

describe "Home", :type => :request do
  before {create_sample_forms}

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
