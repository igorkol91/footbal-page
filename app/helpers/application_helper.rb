module ApplicationHelper
  def follow_exist?(id)
    Following.exists?(follower_id: current_user.id, followed_id: id)
  end

  def current(id)
    return true if id == current_user.id
  end

  def default_photo(photo)
    return photo unless photo.file.nil?

    'https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg'
  end

  def default_cover(cover)
    return cover unless cover.file.nil?

    'https://jordan-medical-services.com/wp-content/plugins/uix-page-builder/uixpb_templates/images/UixPageBuilderTmpl/default-cover-6.jpg'
  end
end
