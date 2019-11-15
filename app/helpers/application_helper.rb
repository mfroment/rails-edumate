module ApplicationHelper
  def user_full_name(user)
    "#{user.first_name} #{user.last_name}"
  end

  def pluralize_with_no(word, count)
    count.zero? ? "no #{word}" : "#{count} #{word.pluralize(count)}"
  end
end
