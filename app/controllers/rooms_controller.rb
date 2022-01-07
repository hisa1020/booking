class RoomsController < ApplicationController
  def index
    @rooms=Room.all
  end

  def new
    @room=Room.new
  end

  def create
    @room=Room.new(params.require(:room).permit(:name, :context, :price, :address, :img, :user_id ))
    if @room.save
      flash[:notice]="ルームの登録に成功しました。"
      redirect_to room_path(@room.id)
    else
      render "new"
    end
  end

  def show
    @room = Room.find(params[:id])
    @reservation = Reservation.new
  end

  def edit
    @room = Room.find(params[:id])
  end

  def update
    @room = Room.find(params[:id])
    if @room.update(params.require(:room).permit(:name, :context, :price, :address, :img))
      flash[:notice]="ルーム情報を更新しました。"
      redirect_to posts_rooms_path
    else
      render "edit"
    end
  end

  def posts
    @rooms = Room.where(user_id: current_user.id)
  end

  def search
    if params[:area].present?
      @rooms = Room.where(['address LIKE ?', "%#{params[:area]}%"])
      render "index"
    elsif params[:keyword].present?
      @rooms = Room.where(['name LIKE ?', "%#{params[:keyword]}%"])
      render "index"
    else
      @rooms = Room.all 
      render "index"
    end
  end

  private
    def room_params
        params.require(:room).permit(:name, :contexrt, :price, :address, :img)
    end
end
