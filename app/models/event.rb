class Event < ActiveRecord::Base
  belongs_to :place
  belongs_to :user
  has_many :comments
  
  paginates_per 9

  def upcoming? 
    DateTime.now < starts_at
  end

  def past? 
    !upcoming?
  end

end
