module HomeHelper

def hot_events
	events = Event.all
	
	events.select{|event| event.starts_at > Time.now}.sort[0..4]		#nearest five future events	
end

end
