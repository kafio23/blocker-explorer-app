require "test_helper"
require "webmock/minitest"

class Fetch < ActiveSupport::TestCase
  SECRET_API_KEY = ENV["API_SECRET_KEY"]

  def test_fetch_data_success
    stub_request(:get, "https://4816b0d3-d97d-47c4-a02c-298a5081c0f9.mock.pstmn.io/near/transactions?api_key=#{SECRET_API_KEY}").
      to_return(status: 200, body: '[{"id": "12"}, {"id": "23"}]'.to_json, headers: { "Content-Type" => "application/json" })

    data = NearApi::Fetch.data

    assert_match '[{"id": "12"}, {"id": "23"}]', data
  end

  def test_fetch_data_error
    stub_request(:get, "https://4816b0d3-d97d-47c4-a02c-298a5081c0f9.mock.pstmn.io/near/transactions?api_key=#{SECRET_API_KEY}").
      to_return(status: 500, body: "Internal Server Error")

    data = NearApi::Fetch.data

    assert_nil(data)
  end
end
