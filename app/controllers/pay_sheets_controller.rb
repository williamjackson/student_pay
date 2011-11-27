class PaySheetsController < ApplicationController
  before_filter :authenticate
  before_filter :authorized_user, :only => [:edit, :update, :destroy]

  def new
    @pay_sheet = current_user.pay_sheets.new
    @title = "Add Pay Sheet"
  end

  def create
    @pay_sheet = current_user.pay_sheets.build((params[:pay_sheet]))
    if @pay_sheet.save
      flash[:success] = "Pay sheet added!"
      redirect_to current_user
    else
      @title = "Add Pay Sheet"
      render 'new'
    end
  end

  def edit
    @pay_sheet = PaySheet.find(params[:id])
    @title = "Edit pay sheet"
  end

  def update
    @pay_sheet = PaySheet.find(params[:id])
    if @pay_sheet.update_attributes(params[:pay_sheet])
      flash[:success] = "Pay sheet updated."
      redirect_to current_user
    else
      @title = "Edit pay sheet"
      render 'edit'
    end
  end

  def destroy
    PaySheet.find(params[:id]).destroy
    flash[:success] = "Pay sheet destroyed."
    redirect_to user_path
  end

  private

    def authorized_user
    @user = User.find(PaySheet.find(params[:id]).user_id)
    redirect_to(root_path) unless (current_user?(@user) || current_user.admin?)
  end
end
