module TweetsHelper
    def find_author(id)
      user = User.find_by('id = ?', id)
      return user.username
    end
end
