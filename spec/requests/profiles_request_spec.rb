require 'rails_helper'

RSpec.describe ProfilesController, type: :controller do
  describe 'GET #show' do
    subject(:make_request) { get :show }

    context 'when user is signed in' do
      include_context 'with current user'

      it_behaves_like 'response with code', code: 200
    end

    context 'when user is NOT signed in' do
      it_behaves_like 'response with code', code: 302
    end
  end

  describe 'PUT #update' do
    subject(:make_request) do
      put :update, params: { id: current_user.id, user: attr }
      current_user.reload
    end
    let(:attr) do
      { name: 'NewName', phone_number: '+70009991123' }
    end

    context 'when user is signed in' do
      include_context 'with current user'
      it 'change name and phone' do
        make_request
        expect(current_user.name).to eql(attr[:name])
        expect(current_user.phone_number).to eql(attr[:phone_number])
      end
    end
  end
end
