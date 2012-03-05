require 'spec_helper'

describe Pastor do

  def reset_pastor(options = {})
    @valid_attributes = {
      :id => 1,
      :name => "RSpec is great for testing too"
    }

    @pastor.destroy! if @pastor
    @pastor = Pastor.create!(@valid_attributes.update(options))
  end

  before(:each) do
    reset_pastor
  end

  context "validations" do
    
    it "rejects empty name" do
      Pastor.new(@valid_attributes.merge(:name => "")).should_not be_valid
    end

    it "rejects non unique name" do
      # as one gets created before each spec by reset_pastor
      Pastor.new(@valid_attributes).should_not be_valid
    end
    
  end

end
