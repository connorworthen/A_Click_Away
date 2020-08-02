class MembersController < ApplicationController
    before_action :require_log_in

    def index
      @user = current_user.id 
    end
    
    def create
      @user = User.find_by(id: params[:user_id])
      if current_user.members << @user
          redirect_to user_path(@user)
        else 
          redirect_to user_path(@user)
        end 
    end 

    def unfollow
      @user = User.find_by(id: params[:user_id])
      relationship = current_user.given_members.find_by(followed_user_id: @user)

      if relationship.destroy
        redirect_to user_path(@user)
      else 
        redirect_to user_path(@user)
      end 
    end 

    def members 
      params[:user_id] && @user = User.find_by_id(params[:user_id])
      @members= @user.members
    end 

    def following 
      params[:user_id] && @user = User.find_by_id(params[:user_id])
      @follows = @user.members 
    end

end