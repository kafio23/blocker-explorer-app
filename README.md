# Block Explorer App

## Overview
This project is a block explorer for the NEAR API built with Ruby on Rails. The main goal of this application is to allow users to explore historical and new transactions. It uses a background Job (executed by Sidekiq Cron) to pull data from NEAR API every hour and create new entities in a PostgreSQL database: blocks, transactions, and actions.

## Requirements
- Ruby: 3.4
- Ruby on Rails: 8.0
- PostgreSQL: 12
- Sidekiq: 8.0
- Sidekiq Cron: 2.2.0 For job scheduling
- Redis: for Sidekiq

## Setup
```
git clone https://github.com/kafio23/blocker-explorer-app
cd blocker-explorer-app
```

## Install Dependencies
```
bundle install
```

## Setup Database
```
rails db:create
rails db:migrate
```

## Environment Variables
Set up the following environment variables:
`API_SECRET_KEY`: The api_key for the NEAR API.

## Project Structure
### Models
* `Blocks`: Represents blockchain blocks. Includes: `black_hash`, `height`, etc
* `Transactions`: Represents blockchain transactions. Belongs to a block. Includes: `transactions_hash`, `sender`, `receiver`, etc
* `Actions`: Represents the actions inside a transaction. Belongs to a Transaction. Includes: `deposit`, `action_type`, etc.
* `DataUpdates`: to track the Job (FetchNearApiDataJob) that pulls data from NEAR API and stores them in the Database.

### Jobs
* `FetchNearApiDataJob`: Sidekiq Cron runs every hour to fetch new data from the NEAR API, processing new blocks, transactions and actions. It uses the block height field (an incrementing integer) to ensure that it **is not adding or processing duplicate blocks**, transactions and actions.

### External Services
* `NearApi::Fetch`: this class interacts with NEAR API in order to fetch transactions data. 

## How it works
### Condition
- The NEAR API shows the latest transaction records added and the data is updated every hour. It is possible that old transactions are no longer shown.

### Approach
- Every hour Sidekiq Cron executes `FetchNearApiDataJob`. This Job pulls transactions data from `NearApi::Fetch` and processes the records **filtering out** the transactions with height lower than the last block height in our local database (Blocks table). Thus, only new records will  be processed.

- The Job is also using `find_or_create_by!` to ensure that there are no duplicate records.

- A new DataUpdate record is created to track Job execution history. It stores the errors if the Job fails.

- The view is showing the `sender`, `receiver` and `deposit` of the transaction records with the **action: "Transfer"** thanks to the following scope:
```ruby
scope :with_transfer_actions, -> { joins(:actions).where(actions: { action_type: TRANSFER_TYPE }).distinct }
```