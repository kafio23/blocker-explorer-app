class Action < ApplicationRecord
  belongs_to :txn, class_name: "Transaction"

  validates :action_type, presence: true
end
