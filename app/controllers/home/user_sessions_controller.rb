class Home::UserSessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    if @user = login(params[:email], params[:password])
      redirect_to root_path
    else
      flash.now[:alert] = t('controllers.login_unsuccessful')
      render action: 'new'
    end
  end

  def destroy
    logout
    redirect_to root_path, notice: t('controllers.logout_successful')
  end
end
