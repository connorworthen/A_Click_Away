class SessionsController < ApplicationController

  def login
    if logged_in?
      redirect_to user_path(session[:user_id])
    else 
      render 'login'
    end 
  end 

  def create
    @user = User.find_or_create_by(uid: auth['uid']) do |u|
      u.name = auth['info']['name']
      u.email = auth['info']['email']
      u.image = auth['info']['image']
    end
 
    session[:user_id] = @user.id
 
    render 'main#home'
  end
    
  def destroy 
    session.delete :user_id 
    redirect_to root_path
  end

  private 

    def user_paramas
      params.require(:user).permit(:username, :password)
    end
    
    def auth
      request.env['omniauth.auth']
    end

end