require 'rails_helper'

RSpec.describe LotsController, type: :controller do
  describe 'GET #index' do
    subject(:make_request) { get :index }

    context 'when user is signed in' do
      include_context 'with current user'

      it_behaves_like 'response with code', code: 200, request_required: true
    end

    context "when user isn't signed in" do
      include_context 'with current user', signed_in: false

      it_behaves_like 'response with code', code: 200, request_required: true
    end
  end

  describe 'GET #new' do
    subject(:make_request) { get :new }

    context 'when user is signed in' do
      include_context 'with current user'

      it_behaves_like 'response with code', code: 200, request_required: true
    end

    context "when user isn't signed in" do
      include_context 'with current user', signed_in: false

      it_behaves_like 'response with code', code: 302, request_required: true
    end
  end

  describe 'GET #create' do
    context 'when user is signed in' do
      include_context 'with current user'

      subject(:make_request) { post :create, params: params }

      let(:params) do
        {
          lot: {
            title: 'New Lot',
            price: 200
          }
        }
      end

      it 'creates new lot' do
        expect { make_request }.to change(Lot, :count).from(0).to(1)
      end
    end

    context 'when user is signed in' do
      include_context 'with current user', signed_in: false

      subject(:make_request) { post :create, params: params }

      let(:params) { { lot: { title: 'My Widget', price: 100 } } }

      it_behaves_like 'response with code', code: 302, request_required: true
    end
  end
end
