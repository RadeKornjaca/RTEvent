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
    context "event's starting time was in the past" do
      before(:each) do
        @past_event = FactoryGirl.build(:event, :starts_at => DateTime.yesterday)
      end

      describe "#past?" do
        it "returns true since event has already happened" do
          expect(@past_event.past?).to be true
        end
      end

      describe "#upcoming?" do
        it "returns false since the event happened in the past" do
          expect(@past_event.upcoming?).to be false
        end
      end

    end    

    context "event's starting time will happen in the future" do
      before(:each) do
        @future_event = FactoryGirl.build(:event, :starts_at => DateTime.tomorrow)
      end

      describe "#past?" do
        it "returns false since the event still hasn't happened" do
          expect(@future_event.past?).to be false
        end
      end

      describe "#upcoming?" do
        it "returns true since the event will eventually happen" do
          expect(@future_event.upcoming?).to be true
        end
      end

    end    

  end

end
