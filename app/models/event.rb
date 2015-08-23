class Event < ActiveRecord::Base
  belongs_to :place
  belongs_to :user
  has_many :comments
  
  validates :title, :presence => true
  validates :user_id, :presence => true
  validates :place_id, :presence => true

  paginates_per 9

  def upcoming? 
    DateTime.now < starts_at
  end

  def past? 
    !upcoming?
  end

end
