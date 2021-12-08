module ApplicationHelper
  def user_avatar(user)
    asset_path('user.jpg')
  end

  def fa_icon
    content_tag 'span', 'x', class: "btn fleat-end", aria: { hidden: true }
  end
end
