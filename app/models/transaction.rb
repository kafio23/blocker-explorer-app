class Transaction < ApplicationRecord
  TRANSFER_TYPE = "Transfer"

  belongs_to :block
  has_many :actions, foreign_key: :txn_id

  validates :transaction_hash, presence: true

  scope :with_transfer_actions, -> { joins(:actions).where(actions: { action_type: TRANSFER_TYPE }).distinct }

  def transfer_action
    actions.find_by(action_type: TRANSFER_TYPE)
  end

  def transfer_action_deposit
    transfer_action&.deposit
  end
end
