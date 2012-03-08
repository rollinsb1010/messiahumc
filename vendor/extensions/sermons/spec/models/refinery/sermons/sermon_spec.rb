require 'spec_helper'

module Refinery
  module Sermons
    describe Sermon do
      describe "validations" do
        subject do
          FactoryGirl.create(:sermon,
          :speaker => "Refinery CMS")
        end

        it { should be_valid }
        its(:errors) { should be_empty }
        its(:speaker) { should == "Refinery CMS" }
      end
    end
  end
end
