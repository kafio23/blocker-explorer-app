class TransactionsController < ApplicationController
  def index
    @transactions = Transaction.with_transfer_actions.order(:time)
    @total_count = Transaction.with_transfer_actions.size
  end
end
