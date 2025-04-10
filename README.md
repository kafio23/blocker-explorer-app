# Block Explorer App

## Overview
This project is a block explorer for the NEAR API built with Ruby on Rails. The main goal of this application is to allow users to explore historical and new transactions. It uses a background Job (executed by Sidekiq Cron) to pull data from NEAR API every 1 hour and create new entities in a PostgreSQL database: blocks, transactions and actions.

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
* `Blocks`: Represents blockchain blocks. Includes: black_hash, height, etc
* `Transactions`: Represents blockchain transactions. Belongs to a block. Includes: transactions_hash, sender, receiver, etc
* `Actions`: Represents the actions inside a transaction. Belongs to a Transaction. Includes: deposit, action_type, etc.
* `DataUpdates`: to track the Job (FetchNearApiDataJob) that pulls data from NEAR API and stores them in the Database.

### Jobs
* `FetchNearApiDataJob`: Sidekiq Cron runs every hour to fetch new data from the NEAR API, processing new blocks, transactions and actions. It uses the block height field (an incrementing integer) to ensure that it **is not** adding or preocessing duplicate blocks, transactions and actions.

### External Services
* `NearApi::Fetch`: this class interacts with NEAR API in order to fetch transactions data. 
