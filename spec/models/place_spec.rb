require "rails_helper.rb"

RSpec.describe Place do
  it { is_expected.to have_db_column(:place_name).of_type(:string) }
  it { is_expected.to have_db_column(:address).of_type(:string) }

  it { is_expected.to have_many(:events) }
end
