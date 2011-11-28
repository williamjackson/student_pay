class PaySheetsController < ApplicationController
  def show
  end

  def new
    @job = Job.find(params[:job_id])
    @user = @job.user
    @pay_period = PayPeriod.current_pay_period
    @title = "New Pay Sheet"
    @pay_sheet = PaySheet.new(:job_id => @job.id, :pay_period_id => @pay_period.id)
    shift_date = @pay_period.end_date

    @shifts = []
    14.times do
     @shifts << @pay_sheet.shifts.build(:date => shift_date)
      shift_date -= 1
    end

    @shifts.sort!{ |a,b| a.date <=> b.date }
    @week1 = @shifts[0..6]
    @week2 = @shifts[7..13]
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

end
