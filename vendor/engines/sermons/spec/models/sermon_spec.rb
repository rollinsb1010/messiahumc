require 'spec_helper'

describe Sermon do

  def reset_sermon(options = {})
    @valid_attributes = {
      :id => 1,
      :speaker => "RSpec is great for testing too"
    }

    @sermon.destroy! if @sermon
    @sermon = Sermon.create!(@valid_attributes.update(options))
  end

  before(:each) do
    reset_sermon
  end

  context "validations" do
    
    it "rejects empty speaker" do
      Sermon.new(@valid_attributes.merge(:speaker => "")).should_not be_valid
    end

    it "rejects non unique speaker" do
      # as one gets created before each spec by reset_sermon
      Sermon.new(@valid_attributes).should_not be_valid
    end
    
  end

end