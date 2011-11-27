class PayPeriod < ActiveRecord::Base

  validates :end_date, :presence => true
  validate :valid_end_date

  private

  def valid_end_date
    if end_date.kind_of? Date
      errors.add(:end_date, "cannot be a date in the past") if end_date < Date.today
      errors.add(:end_date, "must be a sunday") unless end_date.sunday?
    else
      errors.add(:end_date, "must be a date")
    end
  end
end
