require 'spec_helper'

describe PaySheetsController do
  render_views

  describe "access control" do

    it "should deny access to 'new'" do
      post :create
      response.should redirect_to(signin_path)
    end

    it "should deny access to 'create'" do
      post :create
      response.should redirect_to(signin_path)
    end

    it "should deny access to 'destroy'" do
      post :create
      response.should redirect_to(signin_path)
    end
  end

  describe "signed in user" do
    before(:each) do
      @user = Factory(:user)
      @sup = Factory(:user, :email => "sup@utoronto.ca")
      @sup.toggle!(:supervisor)
      test_sign_in(@user)
    end


    describe "DELETE 'destroy'" do

      describe "non admin user trying to delete someone else's pay sheet'" do
        before(:each) do
          @pay_sheet = Factory(:pay_sheet, :user_id => @sup.id)
        end
        it "should redirect to root" do
          delete :destroy, :id => @pay_sheet.id
          response.should redirect_to(root_path)
        end
        it "should not delete the pay sheet" do
          lambda do
            delete :destroy, :id => @pay_sheet.id
          end.should change(User, :count).by(0)
        end
      end
    end
    describe "GET 'new'" do
      it "should be successful" do
        get :new
        response.should be_success
      end

      it "should have the right title" do
        get :new
        response.should have_selector("title", :content => "Add Pay Sheet")
      end
    end
    describe "GET 'edit'" do

      before(:each) do
        @pay_sheet = Factory(:pay_sheet, :user_id => @user.id)
      end

      it "should be successful" do
        get :edit, :id => @pay_sheet
        response.should be_success
      end

      it "should have the right title" do
        get :edit, :id => @pay_sheet
        response.should have_selector("title", :content => "Edit pay sheet")
      end
    end

    describe "POST 'create'" do

      describe "failure" do
        before(:each) do
          @attr = {:name => ''}
        end

        it "should not create a pay sheet" do
          lambda do
            post :create, :pay_sheet => @attr
          end.should_not change(PaySheet, :count)
        end

        it "should have the right title" do
          post :create, :pay_sheet => @attr
          response.should have_selector(:title, :content => "Add Pay Sheet")
        end

        it "should render the 'new' page" do
          post :create, :pay_sheet => @attr
          response.should render_template('new')
        end
      end

      describe "success" do

        before(:each) do
          @attr = {:name => 'default',
                   :supervisor => @sup.id}
        end

        it "should create a pay sheet" do
          lambda do
            post :create, :pay_sheet => @attr
          end.should change(PaySheet, :count).by(1)
        end

        it "should redirect to the user show page" do
          post :create, :pay_sheet => @attr
          response.should redirect_to(user_path(@user))
        end

        it "should have a pay sheet created method" do
          post :create, :pay_sheet => @attr
          flash[:success].should == "Pay sheet added!"
        end
      end
    end
  end
end
