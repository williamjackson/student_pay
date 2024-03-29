require 'spec_helper'

require 'spec_helper'

describe User do

  before(:each) do
    @attr = {:name => "example",
             :email => "user@example.com",
             :password => 'foobar',
             :password_confirmation => 'foobar'}
  end

  it "should create a new instance given valid attributes" do
    User.create!(@attr)
  end

  it "should require a name" do
    no_name_user = User.new(@attr.merge(:name => ""))
    no_name_user.should_not be_valid
  end

  it "should reject names that are too long" do
    long_name = "a" * 51
    long_name_user = User.new(@attr.merge(:name => long_name))
    long_name_user.should_not be_valid
  end

  it "should require unique email address" do
    valid_user = User.create!(@attr)
    invalid_user = User.new(@attr)
    invalid_user.should_not be_valid
  end

  it "should accept valid email addresses" do
    addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    addresses.each do |address|
      valid_email_user = User.new(@attr.merge(:email => address))
      valid_email_user.should be_valid
    end
  end

  it "should reject invalid email addresses" do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
    addresses.each do |address|
      invalid_email_user = User.new(@attr.merge(:email => address))
      invalid_email_user.should_not be_valid
    end
  end

  it "should return a list of supervisors" do
    sup = User.create(@attr)
    sup.toggle!(:supervisor)
    user = User.create(@attr.merge(:email => "test@test.com"))
    sups = User.supervisors
    sups.should == [sup]

  end

  describe "password validations" do

    it "should require a password" do
      User.new(@attr.merge(:password => "", :password_confirmation => "")).
          should_not be_valid
    end

    it "should require a matching password confirmation" do
      User.new(@attr.merge(:password_confirmation => "invalid")).
          should_not be_valid
    end

    it "should reject short passwords" do
      short = "a" * 5
      hash = @attr.merge(:password => short, :password_confirmation => short)
      User.new(hash).should_not be_valid
    end

    it "should reject long passwords" do
      long = "a" * 41
      hash = @attr.merge(:password => long, :password_confirmation => long)
      User.new(hash).should_not be_valid
    end
  end

  describe "password encryption" do

    before(:each) do
      @user = User.create!(@attr)
    end

    it "should have an encrypted password attribute" do
      @user.should respond_to(:encrypted_password)
    end

    it "should set the encrypted password" do
      @user.encrypted_password.should_not be_blank
    end

    describe "has_password? method" do

      it "should be true if the passwords match" do
        @user.has_password?(@attr[:password]).should be_true
      end

      it "should be false if the passwords don't match" do
        @user.has_password?("invalid").should be_false
      end
    end

    describe "authenticate method" do

      it "should return nil on user_name/password mismatch" do
        wrong_password_user = User.authenticate(@attr[:email], "wrongpass")
        wrong_password_user.should be_nil
      end

      it "should return nil for a user_name address with no user" do
        nonexistent_user = User.authenticate("invalid_user", @attr[:password])
        nonexistent_user.should be_nil
      end

      it "should return the user on user_name/password match" do
        matching_user = User.authenticate(@attr[:email], @attr[:password])
        matching_user.should == @user
      end
    end
  end

  describe "admin attribute" do

    before(:each) do
      @user = User.create!(@attr)
    end

    it "should respond to admin" do
      @user.should respond_to(:admins)
    end

    it "should not be an admin by default" do
      @user.should_not be_admin
    end

    it "should be convertible to an admin" do
      @user.toggle!(:admins)
      @user.should be_admin
    end
  end

  describe "supervisor attribute" do

    before(:each) do
      @user = User.create!(@attr)
    end

    it "should respond to supervisor" do
      @user.should respond_to(:supervisor)
    end

    it "should not be a supervisor by default" do
      @user.should_not be_supervisor
    end

    it "should be convertible to a supervisor" do
      @user.toggle!(:supervisor)
      @user.should be_supervisor
    end
  end

  describe "job association" do
    before(:each) do
      @user = User.create(@attr)
      @supervisor = User.create(@attr.merge(:name => "supervisor",
                                            :email => "sup@utoronto.ca"))
      @supervisor.toggle!(:supervisor)
      @ps1 = Factory(:job, :user => @user, :supervisor => @supervisor,
                      :name => "job b")
      @ps2 = Factory(:job, :user => @user, :supervisor => nil,
                      :name => "job a")
    end

    it "should have a job attribute" do
      @user.should respond_to(:jobs)
    end

    it "should have the right jobs in the right order" do
      @user.jobs.should == [@ps2, @ps1]
    end

    it "should destroy associated jobs" do
      @user.destroy
      [@ps1, @ps2].each do |job|
        Job.find_by_id(job.id).should be_nil
      end
    end
  end

  describe "pay_sheet association" do
    it "should have a pay_sheet attribute"
    it "should have the right pay_sheets in the right order"
  end
end