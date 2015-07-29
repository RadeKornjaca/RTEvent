class Event < ActiveRecord::Base
  belongs_to :place
  has_many :comments
  
  paginates_per 9
end
