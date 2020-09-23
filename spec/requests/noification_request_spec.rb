require 'rails_helper'

RSpec.describe NotificationsController, type: :controller do
  describe 'PUT #read' do
    subject(:make_request) { put :read, params: { id: notification.id } }
    let(:notification) { create(:notification, user: current_user) }

    describe 'when user is signed in' do
      include_context 'with current user'

      it 'read notification' do
        expect { make_request }.to change { notification.reload.status }.from('unread').to('read')
      end
    end
  end

  fdescribe 'GET #index' do
    subject(:make_request) { get :index }

    context 'when user is signed in' do
      include_context 'with current user'

      it_behaves_like 'response with code', code: 200
    end

    context 'when user is NOT signed in' do
      it_behaves_like 'response with code', code: 302
    end
  end
end
