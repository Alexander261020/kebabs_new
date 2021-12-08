module ApplicationHelper
  def user_avatar(user)
    asset_path('user.jpg')
  end

  def fa_icon(icon_class)
    content_tag 'span', 'x', class: "btn fleat-end", aria: { hidden: true }
  end

  def event_to_user?
    @event.user == current_user
  end
end
