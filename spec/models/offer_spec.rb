require 'rails_helper'

RSpec.describe Offer, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:suggested_lot).class_name('Lot').inverse_of(:incoming_offers) }
    it { is_expected.to belong_to(:requested_lot).class_name('Lot').inverse_of(:outgoing_offers) }
    it { is_expected.to have_many(:messages) }
    it { should accept_nested_attributes_for(:messages) }
  end

  describe 'validations' do
    # subject { FactoryBot.build(:offer) }
    # before { FactoryBot.create(:offer) }
    it { is_expected.to validate_presence_of(:suggested_lot).with_message('choose suggested lot').with_message('must exist') }
    # it { is_expected.to validate_uniqueness_of(:suggested_lot).scoped_to(:requested_lot).allow_nil }
  end
end
