require 'rails_helper'

RSpec.describe LotsController, type: :request do
  it 'Lots management' do
    @user = create(:user)
    sign_in @user

    get '/lots/new'
    expect(response).to render_template(:new)

    @lot = create(:lot, user: @user)

    expect(response).to redirect_to(assigns(@lot))
    follow_redirect!

    get '/lots'
    expect(response).to render_template(:index)

    # post "/widgets", :params => { :widget => {:name => "My Widget"} }

    # expect(response).to redirect_to(assigns(:widget))
    # follow_redirect!

    # expect(response).to render_template(:show)
    expect(response.body).to include("Widget was successfully created.")
  end

  # it "does not render a different template" do
  #   get "/widgets/new"
  #   expect(response).to_not render_template(:show)
  # end
end
