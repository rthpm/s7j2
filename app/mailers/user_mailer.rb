class UserMailer < ApplicationMailer
  default from: 'rthp@fastmail.com'

  def welcome_email(user)
    @user = user

    @url  = 'http://eventebraille.fr'

    mail(to: @user.email, subject: 'Bienvenue chez nous !')
  end

  def attendance_email(user)
    @user = user

    @url  = 'http://eventebraille.fr'

    mail(to: @user.email, subject: 'Nouvel évènement !')
  end
end
