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
end
