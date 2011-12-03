class AdminsController < ApplicationController
  before_filter :authenticate
  before_filter :admin_user

  def home
  end

  def data
    @users = User.find_all_by_part_time_employee(true)
    @pay_period = PayPeriod.current
  end

  def dbaction
   # called for all db actions
    job_rate = params["c2"]
    user_file = params['c0']

    @mode = params["!nativeeditor_status"]
    @id = params["gr_id"]
    case @mode
      when "updated"
        job = Job.find(@id)
        job.rate = job_rate
        job.user.file = user_file
        job.save!
        @tid = @id
    end

  end
end
