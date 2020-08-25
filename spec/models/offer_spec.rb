require 'rails_helper'

RSpec.describe Offer, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:suggested_lot).class_name('Lot').inverse_of(:incoming_offers) }
    it { is_expected.to belong_to(:requested_lot).class_name('Lot').inverse_of(:outgoing_offers) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:suggested_lot) }
    it { is_expected.to validate_presence_of(:suggested_lot) }
    # it { is_expected.to validate_uniqueness_of(:suggested_lot).scoped_to(:requested_lot) }
  end
end
