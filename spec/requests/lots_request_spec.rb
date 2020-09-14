require 'rails_helper'

RSpec.describe LotsController, type: :controller do
  describe 'GET #index' do
    subject(:make_request) { get :index }

    context 'when user is signed in' do
      include_context 'with current user'

      it_behaves_like 'response with code', code: 200
    end

    context 'when user is NOT signed in' do
      it_behaves_like 'response with code', code: 200
    end
  end

  describe 'GET #new' do
    subject(:make_request) { get :new }

    context 'when user is signed in' do
      include_context 'with current user'

      it_behaves_like 'response with code', code: 200
    end

    context 'when user is NOT signed in' do
      it_behaves_like 'response with code', code: 302
    end
  end

  describe 'POST #create' do
    subject(:make_request) { post :create, params: { lot: lot_params } }
    let(:category) { create(:category) }
    let(:lot_params) { attributes_for :lot, category_id: category.id }

    context 'when user is signed in' do
      include_context 'with current user'

      it 'creates new lot' do
        expect { make_request }.to change(Lot, :count).from(0).to(1)
      end
    end
    context 'when user is NOT signed in' do
      it_behaves_like 'response with code', code: 302
    end
  end

  describe '#destroy' do
    subject(:make_request) { delete :destroy, params: { id: lot.id } }
    let(:category) { create(:category) }
    let!(:lot) { create(:lot, category_id: category.id, user: current_user) }

    context 'when user is signed in' do
      include_context 'with current user'
      it 'delete lot' do
        expect { make_request }.to change(Lot, :count).from(1).to(0)
      end
    end
  end

  describe 'cancel after unpublish any lot' do
    subject(:make_request) { put :unpublish, params: { id: my_lot.id } }

    let!(:my_lot) { create(:lot, user: current_user) }
    let!(:lot) { create(:lot, :with_user) }
    let!(:lot_2) { create(:lot, :with_user) }
    let!(:offer) { create(:offer, suggested_lot: my_lot, requested_lot: lot) }
    let!(:offer_2) { create(:offer, suggested_lot: lot_2, requested_lot: my_lot) }

    context 'when user is signed in' do
      include_context 'with current user'
      it 'cancel outgoing offer' do
        expect { make_request }.to change { offer.reload.status }.from('pending').to('canceled')
      end

      it 'cancel incoming offers' do
        expect { make_request }.to change { offer_2.reload.status }.from('pending').to('canceled')
      end
    end
  end

  describe 'PUT #unpublish' do
    subject(:make_request) { put :unpublish, params: { id: lot.id } }

    let(:lot) { create(:lot, user: current_user) }

    context 'when user is signed in' do
      include_context 'with current user'
      it 'unpublish lot' do
        expect { make_request }.to change { lot.reload.status }.from('published').to('unpublished')
      end
    end
  end

  describe 'PUT #unpublish' do
    subject(:make_request) { put :publish, params: { id: lot.id } }

    let(:lot) { create(:lot, user: current_user, status: :unpublished) }

    context 'when user is signed in' do
      include_context 'with current user'
      it 'unpublish lot' do
        expect { make_request }.to change { lot.reload.status }.from('unpublished').to('published')
      end
    end
  end

  describe 'assigns @offers_i_made' do
    subject(:make_request) { get :show, params: { id: lot.id } }

    let(:my_lot) { create(:lot, user: current_user) }
    let(:my_lot_2) { create(:lot, user: current_user) }
    let(:lot) { create(:lot) }
    let(:lot_2) { create(:lot) }

    let(:my_offer) { create(:offer, suggested_lot: my_lot, requested_lot: lot) }
    let(:my_offer_2) { create(:offer, suggested_lot: my_lot_2, requested_lot: lot) }
    let(:offer) { create(:offer, requested_lot: lot) }
    let(:offer_2) { create(:offer, suggested_lot: lot, requested_lot: lot_2) }

    context 'when user is signed in' do
      include_context 'with current user'
      it 'with my offers' do
        make_request
        expect(assigns(:offers_i_made)).to eq([my_offer, my_offer_2])
      end

      it 'fail with mixed offers' do
        make_request
        expect(assigns(:offers_i_made)).not_to eq([my_offer, offer])
      end

      it 'fail with not my offers' do
        make_request
        expect(assigns(:offers_i_made)).not_to eq([offer, offer_2])
      end
    end
  end
end
