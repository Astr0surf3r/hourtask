# spec/models/user_spec.rb
require 'rails_helper'

RSpec.describe User, type: :model do
  subject { FactoryBot.build(:user) }

  # Validations
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
  it { should validate_confirmation_of(:password) }

  # Associations
  it { should have_many(:companies) }
  it { should have_many(:projects) }
  it { should have_many(:tasks) }

  # Devise modules
  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without an email" do
    subject.email = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a password" do
    subject.password = nil
    expect(subject).to_not be_valid
  end

  it "is not valid with a mismatched password confirmation" do
    subject.password_confirmation = "different_password"
    expect(subject).to_not be_valid
  end
end
