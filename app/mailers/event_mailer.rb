class EventMailer < ApplicationMailer
  def subscription(subscription)
    @email = subscription.user_email
    @name = subscription.user_name
    @event = subscription.event

    # Берём у юзер его email
    mail to: @event.user.email, subject: "#{t '.subscription.new'} #{@event.title}"
  end

  def comment(comment, email)
    @comment = comment
    @event = comment.event
  
    mail to: email, subject: "#{t '.comment.new'} #{@event.title}"
  end

  def photo(photo, email)
    @photo = photo
    @event = photo.event

    mail to: email, subject: "#{t '.photo.new'} #{@event.title}"
  end
end
