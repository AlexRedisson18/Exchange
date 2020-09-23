require 'rails_helper'

RSpec.describe OffersController, type: :controller do
  describe 'POST #create' do
    subject(:make_request) { post :create, params: { offer: offer_params } }
    let(:requested_lot) { create(:lot, :with_user) }
    let(:offer_params) { { requested_lot_id: requested_lot.id, suggested_lot_id: suggested_lot.id } }

    describe 'when user is signed in' do
      include_context 'with current user'

      context 'creates a offer with my suggested lot' do
        let(:suggested_lot) { create(:lot, user: current_user) }
        it 'creates new offer' do
          expect { make_request }.to change(Offer, :count).from(0).to(1)
        end

        it 'creates notification ' do
          expect { make_request }.to change(Notification, :count).from(0).to(1)
        end

        it 'creates "new-offer" notification' do
          make_request
          notification = requested_lot.user.notifications.last
          expect(notification.kind).to eq('new-offer')
        end
      end

      context 'fail if creates a offer with another lot' do
        let(:suggested_lot) { create(:lot, :with_user) }
        it_behaves_like 'response with code', code: 403
      end
    end

    describe 'when user is NOT signed in' do
      context 'fail if creates offer' do
        let(:suggested_lot) { create(:lot, :with_user) }
        it_behaves_like 'response with code', code: 302
      end
    end
  end

  describe 'DELETE #destroy' do
    subject(:make_request) { delete :destroy, params: { id: offer.id } }

    let(:my_lot) { create(:lot, user: current_user) }
    let(:lot) { create(:lot, :with_user) }
    let!(:offer) { create(:offer, suggested_lot: my_lot, requested_lot: lot) }

    context 'when user is signed in' do
      include_context 'with current user'
      it 'delete offer' do
        expect { make_request }.to change(Offer, :count).from(1).to(0)
      end
    end
  end

  describe 'PUT #cancel' do
    subject(:make_request) { put 'cancel', params: { id: offer.id } }
    subject(:make_request_2) { put 'cancel', params: { id: offer_2.id } }

    let(:my_lot) { create(:lot, user: current_user) }
    let(:lot) { create(:lot, :with_user) }
    let(:offer) { create(:offer, suggested_lot: my_lot, requested_lot: lot) }
    let(:offer_2) { create(:offer, suggested_lot: lot, requested_lot: my_lot) }

    context 'when user is signed in' do
      include_context 'with current user'
      it 'cancel offer' do
        expect { make_request }.to change { offer.reload.status }.from('pending').to('canceled')
      end

      it 'create notification ' do
        expect { make_request }.to change(Notification, :count).from(0).to(1)
      end

      it 'create "sender-cancel-offer" notification' do
        make_request
        notification = lot.user.notifications.last
        expect(notification.kind).to eq('sender-cancel-offer')
      end

      it 'create "recipient-cancel-offer" notification' do
        make_request_2
        notification = lot.user.notifications.last
        expect(notification.kind).to eq('recipient-cancel-offer')
      end
    end
  end

  describe 'PUT #unignore' do
    subject(:make_request) { put :unignore, params: { id: offer.id } }

    let(:my_lot) { create(:lot, user: current_user) }
    let(:lot) { create(:lot, :with_user) }
    let(:offer) { create(:offer, suggested_lot: my_lot, requested_lot: lot, status: :canceled) }

    context 'when user is signed in' do
      include_context 'with current user'
      it 'cancel offer' do
        expect { make_request }.to change { offer.reload.status }.from('canceled').to('pending')
      end
    end
  end
end
