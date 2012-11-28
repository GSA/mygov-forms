require 'spec_helper'

describe User do
  
  before do
    User.create :email => "test@test.gov", :password => "testtest"
  end
  
  it "should distinguish between logged in and non-logged in users" do 
    User.new.admin?.should be false
    User.first.admin?.should be true
  end
  
end
