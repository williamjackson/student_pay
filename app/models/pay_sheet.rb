class PaySheet < ActiveRecord::Base

  belongs_to :job
  belongs_to :pay_period

  has_many :shifts

  validates :job_id, :presence => true
  validates :pay_period_id, :presence => true

  validates_uniqueness_of :job_id, :scope => :pay_period_id

  def total_hours
    i = 0
    self.shifts.each do |shift|
      i += shift.hours
    end
    i
  end

  def current_pay_period?
    self.pay_period == PayPeriod.current_pay_period
  end
end
