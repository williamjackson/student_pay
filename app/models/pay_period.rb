class PayPeriod < ActiveRecord::Base

  validates :end_date, :presence => true
  validate :valid_end_date

  has_many :pay_sheets


  def self.gen_next_pay_period_end_date
    last_pay_period = PayPeriod.last
    if last_pay_period.nil?
      next_end_date = Date.today
      while !next_end_date.sunday?
        next_end_date + 1
      end
        return next_end_date
    end
      return last_pay_period.end_date + 14
  end

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
