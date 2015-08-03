# spec/factories/event_factory.rb 

FactoryGirl.define do 
	factory :event do |f| 
		f.title "Zurka"
		f.starts_at DateTime.now
		place
		user 
		f.description "Strava provod"
	end 
end
