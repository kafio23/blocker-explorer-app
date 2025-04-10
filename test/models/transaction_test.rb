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
end
