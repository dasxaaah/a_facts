class MeetupRegistrationsController < ApplicationController
  before_action :authenticate_user!

  FIRST_MEETUP = {
    slug: "vfx-indie-cinema",
    title: "VFX в инди-кино: как создать магию с малым бюджетом",
    starts_at: Time.zone.local(2026, 3, 29, 19, 0),
    url: "https://meet.google.com/ghy-kbaj-bza"
  }.freeze

  def create
    meetup = FIRST_MEETUP

    registration = MeetupRegistration.find_or_initialize_by(
      user: current_user,
      meetup_slug: meetup[:slug]
    )

    if registration.persisted?
      redirect_to community_index_path(tab: "meetups"), notice: "Вы уже записаны на это мероприятие."
      return
    end

    registration.assign_attributes(
      meetup_title: meetup[:title],
      meetup_starts_at: meetup[:starts_at],
      meetup_url: meetup[:url]
    )
    registration.save!

    MeetupMailer.registration_confirmation(registration).deliver_now

    redirect_to community_index_path(tab: "meetups"), notice: "Вы записались на мероприятие. Мы отправили письмо с деталями."
  end

  def destroy
    registration = MeetupRegistration.find_by(
      id: params[:id],
      user: current_user,
      meetup_slug: FIRST_MEETUP[:slug]
    )

    if registration
      registration.destroy!
      redirect_to community_index_path(tab: "meetups"), notice: "Вы отписались от мероприятия."
    else
      redirect_to community_index_path(tab: "meetups"), alert: "Запись на мероприятие не найдена."
    end
  end
end
