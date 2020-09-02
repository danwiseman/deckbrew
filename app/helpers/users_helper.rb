module UsersHelper
    
    def self.PathToUser(user)
        '/u/' + user.slug
    end
    
end
