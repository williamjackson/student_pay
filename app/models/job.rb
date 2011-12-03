class Job < ActiveRecord::Base
  attr_accessible :name, :rate, :department_id

  belongs_to :user
  has_many :pay_sheets
  belongs_to :department

  validates :user_id, :presence => true

  validates :name,  :presence => true,
                    :length   => { :maximum => 40 }

  validates_uniqueness_of :name, :scope => :user_id



  end

