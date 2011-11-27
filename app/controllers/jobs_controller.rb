class JobsController < ApplicationController
  before_filter :authenticate
  before_filter :correct_user, :only => [:edit, :update, :destroy]

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
      redirect_to current_user
    else
      @title = "Edit Job"
      render 'edit'
    end
  end

  def destroy
    Job.find(params[:id]).destroy
    flash[:success] = "Job destroyed."
    redirect_to user_path
  end

  private

    def correct_user
    @user = User.find(Job.find(params[:id]).user_id)
    redirect_to(root_path) unless (current_user?(@user) || current_user.admin?)
  end
end
