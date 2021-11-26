class UsersController < ApplicationController
  before_action :introduction, only: [:edit]
  def show
    @user = User.find(params[:id])
    @codes = @user.codes
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if current_user.update(user_params)
      redirect_to root_path
    else 
      render :edit
    end
  end

  private
  def introduction
    @introduction = "例：現在プログラミングを学習中の社会人\n得意言語：Ruby,HTML/CSS,JavaScript\nひとこと：毎日頑張って書いています"
  end

  def user_params
    params.require(:user).permit(:nickname, :email, :introduction)
  end
end
