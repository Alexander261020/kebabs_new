class Subscription < ActiveRecord::Base
  belongs_to :event
  belongs_to :user, optional: true

  # Обязательно должно быть событие
  validates :event, presence: true

 # если юзер на задан
  with_options if: -> { user.present? } do
    # Для конкретного event_id один юзер может подписаться только один раз
    validates :user, uniqueness: { scope: :event_id }
    validate :self_event?
  end

  # если юзер на задан
  with_options unless: -> { user.present? } do
    validates :user_name, presence: true
    validates :user_email, presence: true, format: /\A[a-zA-Z0-9\-_.]+@[a-zA-Z0-9\-_.]+\z/
    # Или один email может использоваться только один раз (если анонимная подписка)
    validates :user_email, uniqueness: { scope: :event_id }
    validate :email_exist_to_event?
  end


  # validates :user_is_not_creator_of_event
  # Если есть юзер, выдаем его имя,
  # если нет – дергаем исходный метод
  def user_name
    if user.present?
      user.name
    else
      super
    end
  end

  # Если есть юзер, выдаем его email,
  # если нет – дергаем исходный метод
  def user_email
    if user.present?
      user.email
    else
      super
    end
  end

  private

  def email_exist_to_event?
    errors.add(:user_email, :already_exists) if User.exists?(email: user_email)
  end

  def self_event?
    errors.add(:user_email, :restrict_self_subscription) if event.user == user
  end
end
