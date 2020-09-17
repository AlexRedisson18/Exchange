require 'rails_helper'

RSpec.describe Lot, type: :model do
  describe 'enums' do
    it { is_expected.to define_enum_for(:status).with_values(%i[published unpublished]) }
    it { is_expected.to define_enum_for(:state).with_values(%i[excellent good shit]) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:incoming_offers).class_name('Offer').with_foreign_key('requested_lot_id') }
    it { is_expected.to have_many(:outgoing_offers).class_name('Offer').with_foreign_key('suggested_lot_id') }
    it { is_expected.to belong_to(:user) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_length_of(:title).is_at_least(2) }
    it { is_expected.to validate_numericality_of(:price).is_greater_than_or_equal_to(1) }
  end
end
