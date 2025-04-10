class Block < ApplicationRecord
  has_many :transactions

  validates :height, :block_hash, presence: true
end
