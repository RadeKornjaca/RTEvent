require "rails_helper.rb"

RSpec.describe PlacesController, :type => :controller do
  before do
    @user = FactoryGirl.create(:user, :username => "john", :email => "john@doe.com", :password => "password")
    sign_in @user    
  end

  describe "GET #index" do

    before do
      get :index
    end

    it "has to display page with all places" do
      expect(response).to render_template("index") 
    end

  end

  describe "GET #show" do

    before do
      allow(Place).to receive(:find){ @place }
      get :show, :id => 1
    end

    it "has to display page with detailed information about a place" do
      expect(response).to render_template("show")
    end

  end

  describe "POST #create" do
    
    before do
      @place = double(Place) 
      allow(Place).to receive(:new){ @place }
      allow(@place).to receive(:class){ Place }

      @place_params = { :place_name => "Alternativa", :address => "Sarajlijina 5" }
    end 
    
    context "successful place creation" do
      before do
        expect(@place).to receive(:save){ true }
        post :create, :place => @place_params 
      end

      it "has to redirect to that place's detailed page" do
        expect(response).to redirect_to(place_path(@place)) 
      end
    end

    context "unsuccessful place creation" do
      before do
        expect(@place).to receive(:save){ false }
        post :create, :place => @place_params
      end

      it "should make user to fill the form again" do
        expect(response).to render_template("new")
      end
    end

  end

  describe "PUT #update" do

    before do
      @place = double(Place) 
      allow(Place).to receive(:find){ @place }
      allow(@place).to receive(:class){ Place }

      @place_params = { :place_name => "Alternativa", :address => "Sarajlijina 5" }
    end

    context "successful place update" do

      before do
        expect(@place).to receive(:update){ true }
        put :update, :id => 1, :place => @place_params
      end

      it "has to redirect to a place page" do
        expect(response).to redirect_to(place_path(@place))
      end

    end

    context "unsuccessful place update" do

      before do
        expect(@place).to receive(:update){ false }
        put :update, :id => 1, :place => @place_params
      end

      it "should make user to fill the form again" do
        expect(response).to render_template("edit")
      end

    end

  end

  describe "DELETE #destroy" do

    before do
      @place = double(Place)
    end

    context "successful deletion" do 

      before do
        allow(Place).to receive(:find){ @place }
        allow(@place).to receive(:destroy)
      end

      it "has to delete a place" do
        delete :destroy, :id => 1
        expect(response).to redirect_to(places_path)
      end

    end

  end

end

