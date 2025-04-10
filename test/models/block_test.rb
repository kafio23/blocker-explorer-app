require "test_helper"

class BlockTest < ActiveSupport::TestCase
  test "creates a new block" do
    assert_equal(Block.all.size, 2)

    block = Block.new(height: 12345, block_hash: "hash123")

    assert block.save
    assert_equal(Block.all.size, 3)
  end

  test "raises an error" do
    assert_equal(Block.all.size, 2)

    block = Block.new(height: 12345)

    assert_not block.valid?
  end
end
