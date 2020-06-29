class Helpers
  def self.current_user(session_hash)
    @user = User.find(session_hash[:User_id])
  end

  def self.is_logged_in?(session_hash)
    !!session_hash[:User_id]
  end
end
