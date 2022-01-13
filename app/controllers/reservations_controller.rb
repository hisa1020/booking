class ReservationsController < ApplicationController
  def index
    @reservations = Reservation.where(user_id: current_user.id)
  end

  def new
    @reservation = Reservation.new(reservation_params)
    if @reservation.invalid?
      @room = Room.find_by(id: @reservation.room_id)
      render 'rooms/show'
    end
  end

  def create
    @reservation = Reservation.new(reservation_params)
    if @reservation.save
      flash[:notice] = "予約が確定しました。"
      redirect_to reservation_path(@reservation.id)
    end
  end

  def show
    @reservation = Reservation.find(params[:id])
    @room = Room.find_by(id: @reservation.room_id)
  end

  def destroy
    @reservation = Reservation.find(params[:id])
    @reservation.destroy
    flash[:notice] = "予約をキャンセルしました。"
    redirect_to :reservations
  end
  
  def reservation_params
    params.require(:reservation).permit(:start_date, :end_date, :number_of_people, :user_id, :room_id)
  end
end
