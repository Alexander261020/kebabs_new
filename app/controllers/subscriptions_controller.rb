class SubscriptionsController < ApplicationController
  # Задаем родительский event для подписки
  before_action :set_event, only: [:create, :destroy]
  # Задаем подписку, которую юзер хочет удалить
  before_action :set_subscription, only: [:destroy]

  def create
    # Болванка для новой подписки
    @new_subscription = @event.subscriptions.build(subscription_params)

    # проверяем зарегистрирован ли данный email если пользователь не залогинен
    if current_user.nil? && helpers.email_exist?(@new_subscription.user_email)
      redirect_to @event, alert: I18n.t('controllers.subscriptions.dubl_email')
      return
    end

    # если пользователь пытается подписаться на собственное событие
    if helpers.event_to_user?
      redirect_to @event, alert: I18n.t('controllers.subscriptions.self_subscription')
      return
    end

    @new_subscription.user = current_user

    if @new_subscription.valid? && @new_subscription.save
      # Если сохранилось, отправляем письмо
      # Пишем название класса, потом метода и передаём параметры
      # И доставляем методом .deliver_now (то есть в этом же потоке)
      EventMailer.subscription(@event, @new_subscription).deliver_now
      # Если сохранилась, редиректим на страницу самого события
      redirect_to @event, notice: I18n.t('controllers.subscriptions.created')
    else
      # если ошибки — рендерим шаблон события
      render 'events/show', alert: I18n.t('controllers.subscriptions.error')
    end
  end

  def destroy
    message = { notice: I18n.t('controllers.subscriptions.destroyed') }
    if current_user_can_edit?(@subscription)
      @subscription.destroy
    else
      message = { alert: I18n.t('controllers.subscriptions.error') }
    end
  
    redirect_to @event, message
  end

  private

  def set_subscription
    @subscription = @event.subscriptions.find(params[:id])
  end

  def set_event
    @event = Event.find(params[:event_id])
  end

  # Only allow a list of trusted parameters through.
  def subscription_params
    params.fetch(:subscription, {}).permit(:user_email, :user_name)
  end
end
