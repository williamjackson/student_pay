class SupervisorsController < ApplicationController
  before_filter :authenticate

  def index
    jobs = Job.all(
        :include => :user,
        :order => "users.name ASC",
        :conditions => {:department_id => current_user.department})

    @approved_pay_sheets = []
    @jobs_missing_pay_sheets = []
    @unapproved_pay_sheets = []
    pay_period = PayPeriod.current

    jobs.each do |job|
      pay_sheet = job.pay_sheets.find_by_pay_period_id(pay_period.id)
      if pay_sheet.nil?
        @jobs_missing_pay_sheets << job
      elsif pay_sheet.approved?
        @approved_pay_sheets << pay_sheet
      else
        @unapproved_pay_sheets << pay_sheet
      end
    end
  end

end
