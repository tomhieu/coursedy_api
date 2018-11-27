class UserNotifierMailer < ApplicationMailer
  def send_signup_email(user)
    @user = user
    mail( :to => @user.email,
          :subject => 'Thanks for signing up for our amazing app' )
  end

  def send_upcoming_classes_notification(user, course)
    @user = user
    @course = course
    mail( :to => @user.email,
          :subject => 'Upcoming Class' )
  end
end
