require "rails_helper.rb"

RSpec.describe Event do
  it { is_expected.to have_db_column(:title) }
  it { is_expected.to have_db_column(:starts_at) }
  it { is_expected.to have_db_column(:description) }

  it { is_expected.to have_db_index(:user_id) }
  it { is_expected.to belong_to(:user) }

  it { is_expected.to have_db_index(:place_id) }
  it { is_expected.to belong_to(:place) }

  describe "predicate methods" do
    before(:each) do
      @future_event = FactoryGirl.build(:event, :starts_at => DateTime.tomorrow, :user => nil)    # maybe mocking user is a better option here
      @past_event = FactoryGirl.build(:event, :starts_at => DateTime.yesterday, :user => nil)     # but this works for the sake of test cases
    end

    describe ".upcoming?" do
      it "returns true if event's start time is after the current time" do
        expect(@future_event.upcoming?).to eq(true)
        expect(@past_event.upcoming?).to eq(false)
      end
    end

    describe ".past?" do
      it "returns true if event's start time was before the current time" do
        expect(@future_event.past?).to eq(false) 
        expect(@past_event.past?).to eq(true)
      end
    end

  end

end
