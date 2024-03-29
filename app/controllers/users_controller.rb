class UsersController < ApplicationController
  before_filter :authenticate, :only => [:edit, :update, :show, :index,
                                         :destroy, :home]
  before_filter :authorized_user, :only => [:edit, :update, :show]
  before_filter :admin_user, :only => [:destroy]
  before_filter :admin_or_supervisor_user, :only => [:index]

  def new
    @user = User.new
    @title = "Sign up"
  end

  def show
    @user = User.find(params[:id])
    @pay_sheets = @user.pay_sheets.paginate(:page => params[:page])
    @title = @user.name

  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome, thanks for signing up"
      redirect_back_or @user
    else
      @title = "Sign up"
      render 'new'
    end
  end

  def edit
    @title = "Edit user"
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated."
      redirect_to @user
    else
      @title = "Edit user"
      render 'edit'
    end
  end

  def index
    if current_user.admin?
      @title = "All users"
      @users = User.paginate(:page => params[:page])
    elsif current_user.supervisor?
      @title = "Students"
      @users = User.paginate(
          :include => :jobs,
        :order => "users.name ASC",
        :conditions => ["jobs.department_id == ?", current_user.department],
        :page => params[:page])
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_path
  end

  def home
      @jobs = current_user.jobs
      @pay_period = PayPeriod.current
  end

  private

    def authorized_user
    @user = User.find(params[:id])
    authorize_user(@user)
    end
end

