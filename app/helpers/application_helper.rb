module ApplicationHelper
  def user_avatar(user)
    asset_path('user.jpg')
  end  

  def devise_flash
    if controller.devise_controller? && resource.errors.any?
      flash.now[:error] = flash[:error].to_a.concat resource.errors.full_messages
      flash.now[:error].uniq!
    end
  end

  def bootstrap_flash
    alerts_types = [:error, :info, :success, :warning]
    flash_messages = []
    flash.each do |type, message|
    
=begin 
    if flash.any?
      flash.each do |name, message|
        <div class="alert alert-<%= name%> alert-dismissible fade show" role="alert">
          message
          <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
      end
    end 
=end

      next if message.blank?
  
      type = :success if type == :notice
      type = :error   if type == :alert
      next unless alerts_types.include?(type)
  
      Array(message).each do |msg|
        text = content_tag(:div,
                         content_tag(:button, raw("&times;"), :class => "close", "data-dismiss" => "alert") +
                             msg.html_safe, :class => "alert fade in alert-#{type}")
        flash_messages << text if msg
      end
    end
    flash_messages.join("\n").html_safe
  end
end
