class UsersController < ApplicationController
  before_action :require_log_in, only: [:show]

  def new
    @user = User.new
  end 

  def create
    @user = User.create(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path
    else
      render :new
    end
  end 

  def show
    user_helper
  end 

  def edit
    user_helper
  end

  def update
      user_helper
      @user.update(user_params)
      if @user.save
        redirect_to users_path(@user)
      else 
        render :edit 
      end 
    end
      
  private

    def user_params
        params.require(:user).permit(:name, :username, :email, :password)
    end
    
    def user_helper
      @user = User.find_by(params[:id])
    end
end