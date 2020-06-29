shared_examples 'response with code' do |code:|
  it code.to_s do
    make_request
    expect(response).to have_http_status code
  end
end
