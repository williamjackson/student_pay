class Shift < ActiveRecord::Base

  attr_accessible :date, :shift, :hours

  belongs_to :pay_sheet

  validates :date, :presence => true
  validates_uniqueness_of :date, :scope => :pay_sheet_id
  validates :shift, :presence => true
  validates :hours, :presence => true

  private
  def valid_date
    pay_sheet = PaySheet.find(self.pay_sheet_id)
    end_date = PayPeriod.find(pay_sheet.pay_period_id).end_date
    errors.add(:date, "must be within the pay period") unless (date >= (end_date - 14) && date <= end_date)
  end
end
