require "test_helper"

class ActionTest < ActiveSupport::TestCase
  txn = Transaction.last

  test "creates a new action" do
    assert_equal(Action.all.size, 2)

    action = Action.new(txn: txn, action_type: "Transfer")

    assert action.save
    assert_equal(Action.all.size, 3)
  end

  test "raises an error" do
    assert_equal(Action.all.size, 2)

    action = Action.new(txn: txn, action_type: nil)

    assert_not action.valid?
  end
end
