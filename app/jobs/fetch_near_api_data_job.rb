class FetchNearApiDataJob < ApplicationJob
  queue_as :default

  def perform
    started_at = Time.now
    Rails.logger.info "Running FetchNearApiDataJob #{job_id} at #{started_at}"

    last_block_height = Block.order(height: :desc).first&.height || 0
    near_data = NearApi::Fetch.data

    return unless near_data

    data = near_data.filter { |tx| tx["height"] >= last_block_height }

    create_entities(data)
    create_data_update(true, "Data updated sucessfully!", nil, started_at, Time.now)
  rescue StandardError => e
    Rails.logger.error("FetchNearApiDataJob error: #{e.message}")

    create_data_update(false, "Error", e.message, started_at, Time.now)
  end

  private

  def create_entities(data)
    data.each do |params|
      block = Block.find_or_create_by!(block_hash: params["block_hash"]) do |b|
        b.height = params["height"]
      end

      next if Transaction.find_by(transaction_hash: params["hash"])

      transaction = Transaction.create!(transaction_hash: params["hash"]) do |t|
        t.time = params["time"]
        t.block = block
        t.sender = params["sender"]
        t.receiver = params["receiver"]
        t.gas_burnt = params["gas_burnt"]
        t.success = params["success"]
        t.created_at = params["created_at"]
        t.updated_at = params["updated_at"]
      end

      params["actions"].each do |action|
        Action.find_or_create_by!(txn: transaction, action_type: action["type"]) do |a|
          a.deposit = action["data"]["deposit"].to_d
          a.data = action["data"]
        end
      end
    end
  end

  def create_data_update(success, msg, error, started_at, finished_at)
    DataUpdate.create!(
      job_id: job_id,
      logs: msg,
      job_errors: error,
      success: success,
      started_at: started_at,
      finished_at: finished_at
    )
  end
end
