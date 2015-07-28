class Event < ActiveRecord::Base
  belongs_to :place
  has_many :comments
end
