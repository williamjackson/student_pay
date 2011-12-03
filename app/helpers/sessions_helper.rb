module SessionsHelper

  def sign_in(user)
    session[:remember_token] = user.id
    self.current_user = user
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= User.find_by_id(session[:remember_token])
  end

  def current_user?(user)
    user == current_user
  end

  def signed_in?
    !current_user.nil?
  end

  def sign_out
    session.delete(:remember_token)
    self.current_user = nil
  end

  def deny_access
    store_location
    redirect_to signin_path, :notice => "Please sign in to access this page."
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    clear_return_to
  end

  private

  def store_location
    session[:return_to] = request.fullpath
  end

  def clear_return_to
    session[:return_to] = nil
  end

  def authenticate
    deny_access unless signed_in?
  end

  def supervisor_user
    unless current_user.admin? || current_user.supervisor?
      flash[:error] = "Only supervisors can access that page."
      redirect_to(home_path)
    end
  end

  def admin_user
    unless current_user.admin?
      flash[:error] = "Only admins can access that page."
      redirect_to home_path
    end
  end

  def admin_or_supervisor_user
    unless current_user.admin_or_supervisor?
      flash[:error] = "Only admins and supervisor can access this page."
    end
  end

  def authorize_user(user)
    unless (current_user?(user) || current_user.admin_or_supervisor?)
      flash[:error] = "Only admins, supervisor, and the #{user.name} can access
  this page."
      redirect_to(home_path)
    end
  end

  def home_path
    if signed_in?
      return home_admins_path if current_user.admin?
      return supervisors_path if current_user.supervisor?
      home_users_path
    else
      root_path
    end
  end

end
