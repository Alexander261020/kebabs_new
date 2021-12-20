module EventsHelper
  def event_to_user?
    @event.user == current_user
  end

  def event_url
    @event.id.sss
  end
end
