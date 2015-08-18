require "rails_helper.rb"

RSpec.describe PlacesController, :type => :controller do

  describe "POST #create" do
    
    before do
      @place = double(Place)
      allow(Place).to receive(:new){ @place }

      @user = FactoryGirl.create(:user, :username => "john", :email => "john@doe.com", :password => "password")
      sign_in @user    
    end 
    
    it "successful event creation" do
      allow(@place).to receive(:save){ true }
      expect(@place).to receive(:save){ true }
      new_place = { :place => { :place_name => "Alternativa", :address => "Sarajlijina 5" } }
      post :create, new_place 
      #expect(response).to redirect_to(place_path(@place)) 
    end

  end


end

