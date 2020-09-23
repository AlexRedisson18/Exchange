require 'rails_helper'

RSpec.describe Notification, type: :model do
  describe 'enums' do
    it {
      is_expected.to define_enum_for(:kind).with_values(%i[new-offer
                                                           new-message
                                                           sender-cancel-offer
                                                           recipient-cancel-offer
                                                           suggested-lot-unpublished
                                                           requested-lot-unpublished])
    }
    it { is_expected.to define_enum_for(:status).with_values(%i[unread read]) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:lot) }
    it { is_expected.to belong_to(:my_lot).class_name('Lot') }
  end
end
