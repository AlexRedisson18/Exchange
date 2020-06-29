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
    subject(:make_request) { post :create, params: { lot: lot } }
    let(:category) { create(:category) }
    let(:lot) { attributes_for(:lot, category_id: category) }

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
end
