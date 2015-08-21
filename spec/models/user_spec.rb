require "rails_helper.rb"

RSpec.describe User, :type => :model do
  it { is_expected.to have_db_column(:username) }
  it { is_expected.to have_db_column(:email) }
  it { is_expected.to have_db_column(:encrypted_password) }

  it { is_expected.to have_many(:events) }
  it { is_expected.to have_many(:comments) }

  it { is_expected.to validate_presence_of(:username) }
  it { is_expected.to validate_presence_of(:email) }

  it { is_expected.to validate_uniqueness_of(:username) }
  it { is_expected.to validate_uniqueness_of(:email) }

end
