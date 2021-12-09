module ApplicationHelper
  def user_avatar(user)
    if user.avatar?
      user.avatar.url
    else
      asset_path('user.png')
    end
  end

  def fa_icon
    content_tag 'span', 'x', class: "btn fleat-end", aria: { hidden: true }
  end

  def avatar_user_self(user, size_images)
    if user.avatar?
      image_tag(user.avatar.thumb.url, size: "#{size_images}x#{size_images}",
        class: "border border-dark rounded")
    else
      image_tag(asset_pack_path('media/images/user.jpg'), size: "#{size_images}x#{size_images}",
        class: "border border-dark rounded")
    end
  end

  # Возвращает адрес рандомной фотки события, если есть хотя бы одна
  # Или ссылку на картинку по умолчанию
  def event_photo(event)
    photos = event.photos.persisted

    if photos.any?
      photos.sample.photo.url
    else
      asset_pack_path('media/images/event.jpg')
    end
  end

  # Возвращает миниатюрную версию фотки
  def event_thumb(event)
    photos = event.photos.persisted

    if photos.any?
      photos.sample.photo.thumb.url
    else
      asset_path('event_thumb.jpg')
    end
  end
end
