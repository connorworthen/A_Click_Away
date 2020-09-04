module SessionsHelper
   def current_user?(user)
    user == current_user
  end

  def current_user
    if(user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    end
  end
  
end
