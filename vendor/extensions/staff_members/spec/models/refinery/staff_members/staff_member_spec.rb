require 'spec_helper'

module Refinery
  module StaffMembers
    describe StaffMember do
      describe "validations" do
        subject do
          FactoryGirl.create(:staff_member,
          :name => "Refinery CMS")
        end

        it { should be_valid }
        its(:errors) { should be_empty }
        its(:name) { should == "Refinery CMS" }
      end
    end
  end
end
