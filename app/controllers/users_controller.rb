class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      auto_login(@user)
      redirect_to root_path, notice: t('controllers.login_successful')
    else
      render :new
    end
  end

  def update
      if @user.update(user_params)
        redirect_to root_path, notice: t('controllers.update_succsessful')
      else
        render :edit
      end
  end

  def destroy
    @user.destroy
      redirect_to users_url, notice: t('controllers.delete_successful')
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :locale)
  end
end
