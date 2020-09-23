require 'rails_helper'

RSpec.describe MessagesController, type: :controller do
  describe 'POST #create' do
    subject(:make_request) { post :create, params: { message: message_params } }
    let(:message_params) { attributes_for :message, offer_id: offer.id }
    let(:offer) { create(:offer, requested_lot: requested_lot, suggested_lot: suggested_lot) }

    describe 'when user is signed in' do
      include_context 'with current user'

      context 'creates a message with my requested lot in offer' do
        let(:suggested_lot) { create(:lot, :with_user) }
        let(:requested_lot) { create(:lot, user: current_user) }

        it 'creates new message' do
          expect { make_request }.to change(Message, :count).from(0).to(1)
        end

        it 'creates notification ' do
          expect { make_request }.to change(Notification, :count).from(0).to(1)
        end

        it 'creates "new-message" notification' do
          make_request
          notification = suggested_lot.user.notifications.last
          expect(notification.kind).to eq('new-message')
        end
      end

      context 'creates a message with my suggested lot in offer' do
        let(:suggested_lot) { create(:lot, user: current_user) }
        let(:requested_lot) { create(:lot, :with_user) }

        it 'creates new message' do
          expect { make_request }.to change(Message, :count).from(0).to(1)
        end
      end

      context 'fail when create with not mine lots' do
        let(:suggested_lot) { create(:lot, :with_user) }
        let(:requested_lot) { create(:lot, :with_user) }

        it_behaves_like 'response with code', code: 403
      end
    end

    describe 'when user is NOT signed in' do
      context 'fail if creates message' do
        let(:suggested_lot) { create(:lot, :with_user) }
        let(:requested_lot) { create(:lot, :with_user) }

        it_behaves_like 'response with code', code: 302
      end
    end
  end
end
