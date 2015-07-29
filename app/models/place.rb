class Place < ActiveRecord::Base
	has_many :events, dependent: :destroy
	
	paginates_per 5
end
