require "test_helper"

class DataUpdateTest < ActiveSupport::TestCase
  test "creates a new data_update" do
    assert_equal(DataUpdate.all.size, 0)

    data_update = DataUpdate.new(job_id: 12)

    assert data_update.valid?
  end

  test "raises an error" do
    assert_equal(DataUpdate.all.size, 0)

    data_update = DataUpdate.new

    assert_not data_update.valid?
  end
end
