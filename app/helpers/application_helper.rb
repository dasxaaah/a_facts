module ApplicationHelper
  def community_display_name(user)
    user&.name.presence ||
      user&.nickname.presence ||
      user&.email.to_s.split("@").first.presence ||
      "Пользователь"
  end

  def community_avatar_image(user)
    avatar_images = %w[community_avatar_1.png community_avatar_2.png community_avatar_3.png]
    return "community_avatar_1.png" unless user

    user.email == "user0@example.com" ? "community_avatar_4.png" : avatar_images[user.id.to_i % avatar_images.length]
  end
end
