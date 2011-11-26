require 'spec_helper'

describe PaySheet do
  before(:each) do
    @user = Factory(:user)
    @attr = {:name => "Default"}
  end

  it "should create a new instance given valid attributes" do
    @user.pay_sheets.create!(@attr)
  end

  describe "basic functionality" do
    before(:each) do
      @pay_sheet = @user.pay_sheets.create(@attr)
    end
    it "should have a name" do
      @pay_sheet.should respond_to(:name)
    end

    it "should have a supervisor" do
      @pay_sheet.should respond_to(:supervisor_id)
    end

    it "should have a rate" do
      @pay_sheet.should respond_to(:rate)
    end

    it "should have a user attribute" do
      @pay_sheet.should respond_to(:user)
    end

    it "should have the right user association" do
      @pay_sheet.user_id.should == @user.id
      @pay_sheet.user.should == @user
    end
  end

  describe "validations" do

    it "should require a user_id" do
      PaySheet.new(@attr).should_not be_valid
    end
    it "should require a name" do
      no_name_job = @user.pay_sheets.build(@attr.merge(:name =>""))
      no_name_job.should_not be_valid
    end

    it "should have a name that isn't too long'" do
      name = 'a' * 41
      no_name_job = @user.pay_sheets.build(@attr.merge(:name => name))
      no_name_job.should_not be_valid
    end

    it "should have a name that is unique to the user" do
      valid_job = @user.pay_sheets.create(@attr)
      invalid_job = @user.pay_sheets.build(@attr)
      invalid_job.should_not be_valid
    end

    describe "supervisor validation" do
      it "should catch invalid supervisor" do
        invalid_supervisor = @user.pay_sheets.build(
            @attr.merge(:supervisor_id => @user.id))
        invalid_supervisor.should_not be_valid
      end

      it "should accept valid supervisors" do
        @user.toggle!(:supervisor)
        @user.should be_supervisor

        valid_supervisor = @user.pay_sheets.build(
            @attr.merge(:supervisor_id => @user.id))
        valid_supervisor.should be_valid
      end
    end
  end
end

