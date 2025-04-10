class Transaction < ApplicationRecord
  belongs_to :block
  has_many :actions, foreign_key: :txn_id

  validates :transaction_hash, presence: true
end
