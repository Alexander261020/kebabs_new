class PhotosController < ApplicationController
  before_action :set_event, only: [:create, :destroy]
  before_action :set_photo, only: [:destroy]

  # Обратите внимание: фотку может сейчас добавить даже неавторизованный пользовать
  # Смотрите домашки!
  def create
    # Создаем новую фотографию у нужного события @event
    @new_photo = @event.photos.build(photo_params)
    # Проставляем у фотографии пользователя
    @new_photo.user = current_user

    if @new_photo.save
      notify_subscribers(@new_photo)
      # Если фотка сохранилась, редиректим на событие с сообщением
      redirect_to @event, notice: I18n.t('controllers.photos.created')
    else
      # Если нет — рендерим событие с ошибкой
      render 'events/show', alert: I18n.t('controllers.photos.error')
    end
  end

  def destroy
    # нужно будет удалить как разберусь с проблемой отпрвки ссылки через method post
    # также удалить метод get_destroy и очистить маршруты
    @photo = Photo.find(params[:id])
    @event = @photo.event

    message = {notice: I18n.t('controllers.photos.destroyed')}

    # Проверяем, может ли пользователь удалить фотографию
    # Если может — удаляем
    if current_user_can_edit?(@photo)
      @photo.destroy
    else
      # Если нет — сообщаем ему
      message = {alert: I18n.t('controllers.photos.error')}
    end

    # В любом случае редиректим юзера на событие
    redirect_to @event, message
  end

  private

  # Так как фотография — вложенный ресурс, в params[:event_id] рельсы
  # автоматически положат id события, которому принадлежит фотография
  # Это событие будет лежать в переменной контроллера @event
  def set_event
    @event = Event.find(params[:event_id])
  end

  # Получаем фотографию из базы стандартным методом find
  def set_photo
    @photo = @event.photos.find(params[:id])
  end

  # При создании новой фотографии мы получаем массив параметров photo
  # c единственным полем photo
  def photo_params
    params.fetch(:photo, {}).permit(:photo)
  end

  def notify_subscribers(photo)
    # Собираем всех подписчиков и автора события в массив мэйлов, исключаем повторяющиеся
    all_emails = (photo.event.subscriptions.map(&:user_email) + [photo.event.user.email]).uniq
    # Исключаем автора из рассылки
    all_emails.delete(photo.user.email)
    # По адресам из этого массива делаем рассылку
    # Как и в подписках, берём EventMailer и его метод comment с параметрами
    # И отсылаем в том же потоке
    all_emails.each do |mail|
      EventMailer.photo(photo, mail).deliver_now
    end
  end
end
