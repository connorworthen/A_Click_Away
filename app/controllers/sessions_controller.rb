class SessionsController < ApplicationController

  def login
    if logged_in?
      redirect_to user_path(session[:user_id])
    else 
      render 'login'
    end 
  end 

  def create
    @user = User.find_by(email: params[:email])
    if @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else 
      redirect_to '/login'
    end 
  end 
    
  def destroy 
    session.delete :user_id 
    redirect_to '/'
  end 

  private 

    def user_paramas
      params.require(:user).permit(:username, :password)
    end 

end