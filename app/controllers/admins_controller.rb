class AdminsController < ApplicationController
  def view
  end

  def data
    @users = User.find_all_by_part_time_employee(true)
    @pay_period = PayPeriod.current
    render 'data.builder'
  end
end
