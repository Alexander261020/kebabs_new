module EventsHelper
  def event_to_user?
    @event.user == current_user
  end
end
