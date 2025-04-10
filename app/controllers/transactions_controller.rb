class TransactionsController < ApplicationController
  def index
    @total_count = Transaction.with_transfer_actions.size
    @transactions = Transaction.with_transfer_actions.order(:time).page params[:page]
    @current_page = params[:page] || "1"
    @per_page = Kaminari.config.default_per_page
  end
end
