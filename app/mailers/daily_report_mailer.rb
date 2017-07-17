class DailyReportMailer < ApplicationMailer
  default from: "honestraj.it@gmail.com"

  # def send_email_assigned_user(task)
  #   @task = task
  #   mg_client = Mailgun::Client.new ENV['api_key']
  #   message_params =  {:from    => ENV['username'],
  #                      :to      => User.find_by(id:@task.assign_user_id).email,
  #                      :subject => "Tha task #{@task.title} has been assigned by  #{User.find_by(id:task.assign_user_id).full_name} ",
  #                      :text    => 'The Team members over all activities Attached here!'}
  #   mg_client.send_message ENV['domain'], message_params
  # end

  def send_email_assigned_user(task)
    @task = task
    mail(to: User.find_by(id:@task.assign_user_id).email ,
         subject: "The task #{@task.title} has been assigned by #{@task.user.full_name}",
         body:"Hi #{@task.user.full_name},

              Please check the current task at finish #{@task.due_date}

              Regards,
              Team Viber")
  end

end
