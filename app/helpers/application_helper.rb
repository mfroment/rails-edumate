module ApplicationHelper
  def user_full_name(user)
    "#{user.first_name} #{user.last_name}"
  end
end
