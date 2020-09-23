require 'rails_helper'

RSpec.describe NotificationsController, type: :controller do
  fdescribe 'PUT #read' do
    subject(:make_request) { put :read, params: { id: notification.id } }
    let(:notification) { create(:notification, user: current_user) }

    describe 'when user is signed in' do
      include_context 'with current user'

      it 'read notification' do
        expect { make_request }.to change { notification.reload.status }.from('unread').to('read')
      end
    end
  end
end
