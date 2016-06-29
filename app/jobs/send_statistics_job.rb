class SendStatisticsJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    StatisticsMailer.common.deliver
  end
end
