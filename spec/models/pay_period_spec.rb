require 'spec_helper'

describe PayPeriod do
  before(:each) do
  @valid_date = PayPeriod.gen_next_pay_period_end_date
  end

  it "should create a new instance given valid attributes" do
    PayPeriod.create!({:end_date => @valid_date})
  end
  it "should require an end_date" do
    PayPeriod.new(:end_date =>'').should_not be_valid
  end

  describe "a valid end_date" do
    it "should be >= than today's date" do
      PayPeriod.new({:end_date => Date.yesterday}).should_not be_valid
    end

    it "should be a Sunday" do
      PayPeriod.new(:end_date => @valid_date + 1).should_not be_valid
    end

  end
end
