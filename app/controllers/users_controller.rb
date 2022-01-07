class UsersController < ApplicationController
  def show
    @user = current_user
  end

  def profile
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(params.require(:user).permit(:icon, :name, :introduction))
      flash[:notice]="プロフィールの更新に成功しました。"
      redirect_to users_profile_path
    else
      render :profile
    end
  end
end
