

def login(user)
  post_via_redirect user_session_path, 'user[username]' => user.username, 'user[password]' => user.password
end