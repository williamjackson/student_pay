class PaySheetsController < ApplicationController
  include PaySheetsHelper

  def show
  end

  def new
    @title = "New Pay Sheet"
    @job = Job.find(params[:job_id])
    @pay_period = PayPeriod.current
    new_pay_sheet
  end

  def create
    @pay_sheet = PaySheet.new(params[:pay_sheet])
    params[:shifts].each_value do |shift|
      if !shift["hours"].blank?
        @pay_sheet.shifts.build(shift)
      end
    end
    if @pay_sheet.save
       flash[:success] = "Pay sheet created."
      redirect_to current_user.home_path
    else
      edit_pay_sheet
      render :action => 'new'
    end
  end

  def edit
    @title = "Edit Pay Sheet"
    @pay_sheet = PaySheet.find(params[:id])
    edit_pay_sheet
  end

  def update
    @pay_sheet = PaySheet.find(params[:id])
    success = true

    params[:shifts].each_value do |shift|
      begin
        original_shift = @pay_sheet.shifts.find_by_date(shift['date'])
        if !shift["hours"].blank? || !shift["shift"].blank?
          @pay_sheet.shifts.create!(shift) if original_shift.nil?
          original_shift.update_attributes!(shift) if original_shift
        else
          original_shift.destroy if !original_shift.nil?
        end
      rescue ActiveRecord::RecordInvalid
        success = false
      end
    end
    if success
      flash[:success] = "Pay sheet updated."
      redirect_to root_path
    else
      edit_pay_sheet
      flash[:error] = "Pay sheet failed to update."
      render :action => 'edit'
    end
  end

  def destroy
  end

end
