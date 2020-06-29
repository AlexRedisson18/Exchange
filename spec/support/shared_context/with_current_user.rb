RSpec.shared_context 'with current user' do
  let(:current_user) { create(:user) }

  before { sign_in current_user }
end
