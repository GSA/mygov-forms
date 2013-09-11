require 'spec_helper'

describe Submission do
  before do
    @valid_attributes = {
      :data => {:field_a => "A", :field_b => "B"}
    }
    @form = FactoryGirl.create(:form)

  end

  it "should create a new submission with valid attributes, and generate a guid" do
    submission = Submission.new(@valid_attributes)
    submission.form_id = @form.id
    submission.save!
    submission.guid.should_not be_nil
  end

  it "should not create without a form id" do
    Submission.create(@valid_attributes).errors.should_not be_empty
  end
end
