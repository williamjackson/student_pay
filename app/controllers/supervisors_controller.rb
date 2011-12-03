class SupervisorsController < ApplicationController
  before_filter :authenticate

  def index
    @supervised_jobs = Job.find(
        :all,
        :include => :user,
        :order => "users.name ASC",
        :conditions => {:department_id => current_user.department})
  end

end
