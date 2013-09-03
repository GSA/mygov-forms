unless ENV.has_key?('NO_ACC')
  require 'spec_helper'

  describe "Accessibility" do
    before { @session ? @session.reset_session! : @session = Capybara::Session.new(:accessible, Rails.application) }
    after { @session.driver.browser.close }

    describe "forms#index" do

        it "displays the home page" do
          @session.visit root_path
        end

      context "when there are forms in the database" do
        before {create_sample_forms}

        it "lists the forms on the home page and links to those forms by title and number" do
          @session.visit root_path
        end

        it "should let a user navigate to a form and fill it out" do
          @session.visit root_path
          @session.click_link 'Sample Form 1 (S-1)'
          @session.click_link 'Take me to the form'
          @session.fill_in 'data_text_field', with: 'America'
          @session.click_button "Submit"
        end

        context "when a form has OMB data associated with it" do
          it 'displays the OMB number and expiration date at the bottom of a form' do
            @session.visit root_path
            @session.click_link 'Sample Form 1 (S-1)'
          end
        end

        context "when a form does not have OMB data associated with it" do
          it 'does not display the omb info at the bottom of a form when the form does not have associated omb data' do
            @session.visit root_path
            @session.click_link 'Sample Form 2 (S-2)'
          end
        end

        context "when the form has a PDF associated with it" do
          before do
            pdf = @sample_form_1.build_pdf(url: "http://example.gov/form.pdf")
            pdf.save!
            pdf_field = pdf.pdf_fields.create!(name: 'text_field')
            pdf_field.form_field = @sample_form_1.form_fields.first
            pdf_field.save!
          end

          it "allows the user to download a PDF version of their form" do
            @session.visit root_path
            @session.click_link 'Sample Form 1 (S-1)'
            @session.click_link 'Take me to the form'
            @session.fill_in 'A Text Field', with: 'America'
            @session.click_button "Submit"
          end
        end
      end
    end
  end
end