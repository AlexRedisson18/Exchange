require 'rails_helper'

RSpec.describe Lot, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:incoming_offers).class_name('Offer').inverse_of(:suggested_lot) }
    it { is_expected.to have_many(:outgoing_offers).class_name('Offer').inverse_of(:requested_lot) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_length_of(:title).is_at_least(2) }
    it { is_expected.to validate_numericality_of(:price).is_greater_than_or_equal_to(1) }
  end
end
