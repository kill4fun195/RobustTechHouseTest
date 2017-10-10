class UsersController < ApplicationController
   before_action :set_user, only: [:show, :edit, :update, :destroy]

  def show

  end

  def update
    if user_params[:avatar].present?
      @user.create_avatar(image: params[:user][:avatar])
    end
    redirect_to user_path(@user)
  end

  private
  
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:emai, :avatar)
    end 

end
