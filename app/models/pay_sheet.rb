class PaySheet < ActiveRecord::Base
  attr_accessible :name, :rate, :supervisor_id

  belongs_to :user
  belongs_to :supervisor, :class_name => "User", :foreign_key => "supervisor_id"

  validates :user_id, :presence => true

  validates :name,  :presence => true,
                    :length   => { :maximum => 40 }

  validates_uniqueness_of :name, :scope => :user_id

  validate :valid_supervisor


  private

  def valid_supervisor
    if !supervisor_id.blank? and !User.find(supervisor_id).supervisor?
      errors.add(:supervisor_id, "can't be a non supervisor user")
    end
  end
end
