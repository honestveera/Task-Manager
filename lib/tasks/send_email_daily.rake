namespace :send_email_daily do
  desc "TODO"

  task daily_email: :environment do
   DailyReportMailer.daily_report().deliver!
  end

end
