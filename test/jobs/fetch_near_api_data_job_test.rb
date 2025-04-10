require "test_helper"
require "webmock/minitest"

class FetchNearApiDataJobTest < ActiveJob::TestCase
  SECRET_API_KEY = ENV["API_SECRET_KEY"]

  test "creates data correctly" do
    mock_data = File.read(Rails.root.join("test/fixtures/files/near_api/mock_data.json"))

    stub_request(:get, "https://4816b0d3-d97d-47c4-a02c-298a5081c0f9.mock.pstmn.io/near/transactions?api_key=#{SECRET_API_KEY}").
      to_return(status: 200, body: mock_data, headers: { "Content-Type" => "application/json" })

    Action.delete_all
    Transaction.delete_all
    Block.delete_all

    job = FetchNearApiDataJob.new
    job.perform_now

    assert_equal(Block.all.size, 5)
    assert_equal(Transaction.all.size, 5)
    assert_equal(Action.all.size, 5)
    assert_equal(DataUpdate.all.size, 1)

    data_update = DataUpdate.last

    assert_match(job.job_id, data_update.job_id)
    assert_match("Data updated sucessfully!", data_update.logs)
    assert_not_nil data_update.started_at
    assert_not_nil data_update.finished_at
  end
end
