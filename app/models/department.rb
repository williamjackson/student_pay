class Department < ActiveRecord::Base
  has_many :users
  has_many :jobs

  validates :name,  :presence => true,
                    :length   => { :maximum => 60 },
                    :uniqueness => {:case_sensitive => false}


end
