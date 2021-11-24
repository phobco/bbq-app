module ApplicationHelper
  def user_avatar(user)
    asset_path('user.png')
  end

  def flash_class_name(name)
    case name
    when 'notice' then 'success'
    when 'alert'  then 'danger'
    else name
    end
  end
end
