require 'sidekiq/cron/job'

Sidekiq::Cron::Job.create(
  name: "Send top sales email every day",
  cron: '0 8 * * *',
  class: 'SendTopSalesEmailJob'
)