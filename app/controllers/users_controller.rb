class UsersController < ApplicationController
  def new
    @title = "Add user"
  end
  
  def show
    @user = User.find_by_user_name(params[:id])
  end

end
