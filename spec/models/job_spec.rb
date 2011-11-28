require 'spec_helper'

describe Job do
  before(:each) do
    @user = Factory(:user)
    @attr = {:name => "Default"}
  end

  it "should create a new instance given valid attributes" do
    @user.jobs.create!(@attr)
  end

  describe "basic functionality" do
    before(:each) do
      @job = @user.jobs.create(@attr)
    end
    it "should have a name" do
      @job.should respond_to(:name)
    end

    it "should have a supervisor" do
      @job.should respond_to(:supervisor_id)
    end

    it "should have a rate" do
      @job.should respond_to(:rate)
    end

    it "should have a user attribute" do
      @job.should respond_to(:user)
    end

    it "should have the right user association" do
      @job.user_id.should == @user.id
      @job.user.should == @user
    end
  end

  describe "validations" do

    it "should require a user_id" do
      Job.new(@attr).should_not be_valid
    end
    it "should require a name" do
      no_name_job = @user.jobs.build(@attr.merge(:name =>""))
      no_name_job.should_not be_valid
    end

    it "should have a name that isn't too long'" do
      name = 'a' * 41
      no_name_job = @user.jobs.build(@attr.merge(:name => name))
      no_name_job.should_not be_valid
    end

    it "should have a name that is unique to the user" do
      valid_job = @user.jobs.create(@attr)
      invalid_job = @user.jobs.build(@attr)
      invalid_job.should_not be_valid
    end

    describe "supervisor validation" do
      it "should catch invalid supervisor" do
        invalid_supervisor = @user.jobs.build(
            @attr.merge(:supervisor_id => @user.id))
        invalid_supervisor.should_not be_valid
      end

      it "should accept valid supervisors" do
        @user.toggle!(:supervisor)
        @user.should be_supervisor

        valid_supervisor = @user.jobs.build(
            @attr.merge(:supervisor_id => @user.id))
        valid_supervisor.should be_valid
      end
    end
  end
end

