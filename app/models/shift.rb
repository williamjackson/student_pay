class Shift < ActiveRecord::Base

  attr_accessible :date, :shift, :hours

  belongs_to :pay_sheet

  validates :date, :presence => true
  validates_uniqueness_of :date, :scope => :pay_sheet_id
  validates :shift, :presence => true
  validates :hours, :presence => true
  validate :valid_date

  private
  def valid_date
    pay_sheet = self.pay_sheet
    end_date = pay_sheet.pay_period.end_date
    errors.add(:date, "must be within the pay period") unless (date >= (end_date - 14) && date <= end_date)
  end
end
