require 'rails_helper'

RSpec.describe Project, type: :model do
  describe 'associations' do
    it { should have_many(:tasks).dependent(:destroy) }
    it { should have_many(:payment_items).dependent(:destroy) }
    it { should have_many(:discounts).dependent(:destroy) }
    it { should belong_to(:company) }
    it { should belong_to(:user) }
  end

  describe 'factory' do
    it 'has a valid factory' do
      expect(build(:project)).to be_valid
    end
  end

end
