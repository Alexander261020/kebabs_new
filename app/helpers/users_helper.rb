module UsersHelper
  def email_exist?(user_email)
    User.exists?(:email => user_email)
  end
end
