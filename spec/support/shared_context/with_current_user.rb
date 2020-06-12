RSpec.shared_context 'with current user' do |signed_in: true|
  let(:current_user) { create(:user) }

  before { sign_in current_user } if signed_in
end
