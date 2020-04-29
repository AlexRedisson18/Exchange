require 'rails_helper'

RSpec.describe Offer, type: :model do
  describe 'relations' do
    it { is_expected.to belong_to(:suggested_lot).class_name('Lot').inverse_of(:incoming_offers) }
    it { is_expected.to belong_to(:requested_lot).class_name('Lot').inverse_of(:outgoing_offers) }
  end
end
