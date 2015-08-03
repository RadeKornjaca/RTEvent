# spec/factories/user_factory.rb 

FactoryGirl.define do 
	factory :user do |f|
	  f.email 'radisic.rade@gmail.com'
		f.username 'rade'
  	f.password 'password'
	end 
end
