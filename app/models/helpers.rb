helpers do

  def self.current_user
    !!current_user
  end

  def self.is_logged_in?
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

end