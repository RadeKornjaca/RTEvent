require "rails_helper.rb"

RSpec.describe EventsController, :type => :controller do
  
  before do
    @user = double(User)
    allow(controller).to receive(:current_user){ @user }
    allow(controller).to receive(:authenticate_user!)
  end 

  describe "GET #index" do

    before do
      get :index
    end

    it "has to show page with events" do
      expect(response).to render_template("index")
    end

  end

  describe "GET #show" do

    before do
      allow(Event).to receive(:find)
      get :show, :id => 1
    end

    it "has to show page with events" do
      expect(response).to render_template("show")
    end

  end

  describe "POST #create" do  
       
    before do
      @event = double(Event)
      allow(@event).to receive(:class){ Event }
      allow(@user).to receive_message_chain(:events, :build){ @event }

      @event_params = { :title => "Event", :place_id => 1, :description => "Description" }
    end

    context "successful event creation" do 

      before do
        expect(@event).to receive(:save){ true }
        post :create, :event => @event_params 
      end

      it "should redirect to a page with that event's information" do
        expect(response).to redirect_to(event_path(@event)) 
      end

    end

    context "unsuccessful event creation" do

      before do
        expect(@event).to receive(:save){ false }
        post :create, :event => @event_params
      end

      it "will render new event template" do
        expect(response).to render_template("new")
      end
    end

  end

  describe "PUT #update" do
    before do
      @event = double(Event)
      allow(Event).to receive(:find){ @event }
      allow(@event).to receive(:class){ Event }

      @event_params = { :title => "Event", :place_id => 1, :description => "Description" }
    end

    context "successful event update" do
      before do
        expect(@event).to receive(:update){ true }
        put :update, :id => 1, :event => @event_params
      end

      it "has to redirect to a detailed event view" do
        expect(response).to redirect_to(event_path(@event))
      end

    end

    context "unsuccessful event update" do
      before do
        expect(@event).to receive(:update){ false }
        put :update, :id => 1, :event => @event_params
      end

      it "should make user to fill the event form again" do
        expect(response).to render_template("edit")
      end
    end

  end

  describe "DELETE #destroy" do
    before do
      expect(Event).to receive(:find){ @event }
      expect(@event).to receive(:destroy)

      delete :destroy, :id => 1
    end

    it "should redirect to events page" do
      expect(response).to redirect_to(events_path)
    end
  end

end
