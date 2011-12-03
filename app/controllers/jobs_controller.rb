class JobsController < ApplicationController
  before_filter :authenticate
  before_filter :authorized_user, :only => [:edit, :update, :destroy]

  def new
    @job = current_user.jobs.new
    @title = "Add Job"
  end

  def create
    @job = current_user.jobs.build((params[:job]))
    if @job.save
      flash[:success] = "Job added!"
      redirect_to current_user
    else
      @title = "Add Job"
      render 'new'
    end
  end

  def edit
    @job = Job.find(params[:id])
    @title = "Edit Job"
  end

  def update
    @job = Job.find(params[:id])
    if @job.update_attributes(params[:job])
      flash[:success] = "Job updated."
      redirect_to user_path(@job.user)
    else
      @title = "Edit Job"
      render 'edit'
    end
  end

  def destroy
    job = Job.find(params[:id])
    user = job.user
    if job.pay_sheets.blank?
      job.destroy
      flash[:success] = "Job destroyed."
    else
      flash[:error] = "Can't delete job's which are associated with submitted pay sheets"
    end
    redirect_to user_path(user)
  end

  private

  def authorized_user
    @user = User.find(Job.find(params[:id]).user_id)
    authorize_user(@user)       # find in sessions helper
  end
end
