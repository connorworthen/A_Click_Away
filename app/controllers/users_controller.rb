class UsersController < ApplicationController
  before_action :require_log_in, only: [:show]

  def new
    if logged_in?
      redirect_to user_path(current_user)
    else
      @user = User.new
    end
  end 

  def create
    @user = User.create(user_params)
    if @user.valid?
      @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      render :new
    end
  end 

  def show
    @user = User.find_by(id: params[:id])
  end 
      
  private

    def user_params
        params.require(:user).permit(:name, :username, :email, :password)
    end 
end