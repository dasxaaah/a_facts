class MeetupMailer < ApplicationMailer
  def registration_confirmation(registration)
    @registration = registration
    @user = registration.user

    mail(
      to: @user.email,
      from: "AFACTS <z.znaranzaya@gmail.com>",
      subject: "Вы записались на мероприятие «#{@registration.meetup_title}»"
    )
  end
end
