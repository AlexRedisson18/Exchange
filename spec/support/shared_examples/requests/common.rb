shared_examples "response with code" do |code:, request_required: false|
  it code.to_s do
    make_request if request_required
    expect(response).to have_http_status code
  end
end
