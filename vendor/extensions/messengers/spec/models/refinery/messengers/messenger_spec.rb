require 'spec_helper'

module Refinery
  module Messengers
    describe Messenger do
      describe "validations" do
        subject do
          FactoryGirl.create(:messenger, messenger_type: 'weekly')
        end

        it { should be_valid }
        its(:errors) { should be_empty }
        its(:messenger_type) { should == 'weekly' }
      end
    end
  end
end
