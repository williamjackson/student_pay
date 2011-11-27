module PaySheetsHelper
  def current_supervisor(pay_sheet)
    if pay_sheet.supervisor.nil?
      "-Select supervisor"
    else
      pay_sheet.supervisor
    end
  end
end
