class Dashboard::PacksController < ApplicationController
  before_action :set_pack, only: [:edit, :update, :destroy, :set_as_current, :reset_as_current]

  def index
    @packs = current_user.packs.order id: :asc
  end

  def new
    @pack = Pack.new
  end

  def edit
  end

  def create
    @pack = current_user.packs.build(pack_params)
    if @pack.save
      redirect_to packs_path
    else
      render :new
    end
  end

  def update
    if @pack.update(pack_params)
      redirect_to packs_url
    else
      render :edit
    end
  end

  def destroy
    @pack.destroy
    redirect_to packs_url
  end

  def set_as_current
    current_user.make_active(@pack)
    redirect_to packs_path
  end

  def reset_as_current
    current_user.make_inactive
    redirect_to packs_path
  end

  private

    def set_pack
      @pack = current_user.packs.find(params[:id])
    end

    def pack_params
      params.require(:pack).permit(:title)
    end
end
