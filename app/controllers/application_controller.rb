class ApplicationController < ActionController::Base
  helper_method :logged_in?
  helper_method :current_user
  helper_method :require_log_in
  
  def logged_in?
    !!session[:user_id]
  end
    
  def current_user
    @current_user ||= User.find_by_id(session[:user_id])  if  !!session[:user_id]
  end

  def require_log_in
    if !logged_in? 
      redirect_to '/'
    end 
  end

end
