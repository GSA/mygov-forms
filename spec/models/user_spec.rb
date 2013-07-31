require 'spec_helper'

describe 'User' do
  context 'When a user is created' do

    context 'when that user is the first' do
      it 'should assign the admin role to the first user' do
        User.destroy_all
        user = User.create!(:name => 'Joe', :email => 'joe@citizen.org')
        (user.has_role? :admin).should == true
      end
    end

    context 'when the user is not the first' do
      before do
        user = User.create!(:name => 'Joe', :email => 'admin@citizen.org')
      end

      it 'should not automatically assign the admin role' do
        user = User.create!(:name => 'Joe', :email => 'joe@citizen.gov')
      (user.has_role? :admin).should == false
      end
    end

    it "should assign the agency role to a .gov user" do
      user = User.create!(:name => 'Joe', :email => 'joe@citizen.gov')
      (user.has_role? :agency).should == true
    end

    it "should assign the agency role to a .mil user" do
      user = User.create!(:name => 'Joe', :email => 'joe@citizen.mil')
      (user.has_role? :agency).should == true
    end
  end
end
