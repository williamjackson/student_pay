module PaySheetsHelper

  def new_pay_sheet
    @user = @job.user

    @pay_sheet = PaySheet.new(:job_id => @job.id, :pay_period_id => @pay_period.id)
    @shifts = []
    shift_date = @pay_period.end_date
    14.times do
      @shifts << @pay_sheet.shifts.build(:date => shift_date)
      shift_date -= 1
    end
    @shifts.sort! { |a, b| a.date <=> b.date }

  end

    def edit_pay_sheet
    if !@pay_sheet.current_pay_period?
      flash[:error] = "Can't edit past pay sheets"
      redirect_to root_path
    end
    @shifts = []
    shift_date = @pay_sheet.pay_period.end_date
    14.times do
      shift = @pay_sheet.shifts.find_by_date(shift_date)
      if shift.nil?
        @shifts << @pay_sheet.shifts.build(:date => shift_date)
      else
        @shifts << shift
      end
      shift_date -= 1
    end
    @shifts.sort! { |a, b| a.date <=> b.date }
  end
end
