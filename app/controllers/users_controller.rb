class UsersController < ApplicationController
  def new
    @user = User.new
    @title = "Sign up"
  end
  
  def show
    @user = User.find_by_user_name(params[:id])
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:success] = "Welcome, thanks for signing up"
      redirect_to @user
    else
      @title = "Sign up"
      render 'new'
    end
  end
end
