class TaskMailer < ApplicationMailer
  include ApplicationHelper
  default from: "vipandriy27@gmail.com"
  def new_task_mail (user,sender )
    @user=user
    @sender=sender
    mail(to: @user.email, subject: 'You get new task')
  end
end
