class DailyReportEmailJob < ActiveJob::Base
  queue_as :default

  def perform(task)
   @task = task
   DailyReportMailer.send_email_assigned_user(@task).deliver_later
  end
end
