require "test_helper"

class TransactionTest < ActiveSupport::TestCase
  block = Block.last

  test "creates a new transaction" do
    assert_equal(Transaction.all.size, 3)

    transaction = Transaction.new(
      transaction_hash: "hash12345",
      block: block
    )

    assert transaction.save
    assert_equal(Transaction.all.size, 4)
  end

  test "raises an error" do
    assert_equal(Transaction.all.size, 3)

    transaction = Transaction.new(
      transaction_hash: nil,
      block: block
    )

    assert_not transaction.valid?
  end

  test "shows transfer transactions" do
    assert_equal(Transaction.with_transfer_actions.size, 1)
  end

  test "shows one transaction deposit" do
    transaction = Transaction.with_transfer_actions.first

    assert(456, transaction.transfer_action_deposit)
  end
end
