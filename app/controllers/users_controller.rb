class UsersController < ApplicationController
  def show
    @user =User.find(params[:id])
    @books = @user.books
  end

  def edit
    @user =User.find(params[:id])
    redirect_to user_path(current_user) unless @user == current_user
  end

  def update
    @user =User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] ="Update successfully"
      redirect_to @user
    else
      @users =User.all
      flash.now[:alert] ="Update error!"
      render :edit
    end
  end
  def index
    @users =User.all
  end

  def user_params
    params.require(:user).permit(:name,:profile_image,:introduction)
  end
end
