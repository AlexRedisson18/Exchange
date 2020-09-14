require 'rails_helper'

RSpec.describe Offer, type: :model do
  describe 'enums' do
    it { is_expected.to define_enum_for(:status).with_values(%i[pending canceled]) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:suggested_lot).class_name('Lot').inverse_of(:incoming_offers) }
    it { is_expected.to belong_to(:requested_lot).class_name('Lot').inverse_of(:outgoing_offers) }
    it { is_expected.to have_many(:messages) }
    it { should accept_nested_attributes_for(:messages) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:suggested_lot).with_message('choose suggested lot').with_message('must exist') }
  end
end
