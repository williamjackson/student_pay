require 'spec_helper'

describe PaySheet do
  before (:each) do
    @attr = {:pay_period_id => 1,
             :job_id => 1,
             :approved => false}
  end
  it "should have a pay_period_id" do
    PaySheet.new(@attr).should respond_to(:pay_period_id)

  end
  it "should have a job_id" do
    PaySheet.new(@attr).should respond_to(:job_id)
  end
  it "should have a approved" do
    PaySheet.new(@attr).should respond_to(:approved)
  end
  it "should create a new instance given valid attributes" do
    PaySheet.create!(@attr)
  end

  describe "validation" do
    it "should require a pay_period_id" do
      PaySheet.new(@attr.merge(:pay_period_id => "")).should_not be_valid
    end
    it "should require a job_id" do
      PaySheet.new(@attr.merge(:job_id => "")).should_not be_valid
    end
    it "should require a unique pay_period_id job_id combination" do
      PaySheet.create!(@attr)
      PaySheet.new(@attr).should_not be_valid
    end

  end
end
