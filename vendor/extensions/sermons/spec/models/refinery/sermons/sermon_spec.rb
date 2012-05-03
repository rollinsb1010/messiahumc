require 'spec_helper'

module Refinery
  module Sermons
    describe Sermon do
      describe "validations" do
        subject do
          FactoryGirl.create(:sermon, title: "Refinery CMS")
        end

        it { should be_valid }
        its(:errors) { should be_empty }
        its(:title) { should == "Refinery CMS" }
      end

      describe '.recent' do
        let(:sermons) { [FactoryGirl.build(:sermon), FactoryGirl.build(:sermon)] }

        it 'returns the ordered sermons' do
          Sermon.should_receive(:includes).with(:pastor).and_return Sermon
          Sermon.should_receive(:order).with('date DESC').and_return sermons
          Sermon.recent.should == sermons
        end
      end
    end
  end
end
