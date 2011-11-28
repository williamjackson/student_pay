require 'spec_helper'

describe Shift do
  before(:each) do
    @user = Factory(:user)
    @job  = Factory(:job, :user => @user)
    @pay_period = Factory(:pay_period)
    @pay_sheet = Factory(:pay_sheet, :pay_period => @pay_period, :job => @job)
    @attr = {:date => @pay_period.end_date, :shift => "9-12", :hours => 3}
  end

  it "should create a new instance with valid attributes" do
    @pay_sheet.shifts.create!(@attr)
  end
  it "should require a date >= pay_period.end_date - 14" do
    @pay_sheet.shifts.build(
        @attr.merge(:date => @pay_period.end_date - 15)).should_not be_valid
  end
  it "should require a date <= pay_period.end_date" do
    @pay_sheet.shifts.build(
        @attr.merge(:date => @pay_period.end_date + 1)).should_not be_valid
  end
  it "should require a unique [pay_sheet_id, date]" do
    @pay_sheet.shifts.create!(@attr)
    @pay_sheet.shifts.build(@attr).should_not be_valid
  end
  it "should require hours" do
     @pay_sheet.shifts.build(@attr.merge :hours => '').should_not be_valid
  end

  it "should require a shift" do
    @pay_sheet.shifts.build(@attr.merge :shift => '').should_not be_valid
  end
end
