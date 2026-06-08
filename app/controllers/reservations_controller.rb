class ReservationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_reservation, only: [ :edit, :update, :destroy ]

  def index
    @reservations = current_user.reservations.includes(:room)
  end

  def new
    @room = Room.find(params[:room_id])
    @reservation = Reservation.new
  end

  def create
    @room = Room.find(params[:room_id])
    @reservation = current_user.reservations.build(reservation_params)
    @reservation.room = @room
    if @reservation.save
      redirect_to reservations_path, notice: "予約が完了しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @room = @reservation.room
  end

  def update
    if @reservation.update(reservation_params)
      redirect_to reservations_path, notice: "予約を更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @reservation.destroy
    redirect_to reservations_path, notice: "予約を削除しました"
  end

  private

  def set_reservation
    @reservation = current_user.reservations.find(params[:id])
  end

  def reservation_params
    params.require(:reservation).permit(:check_in, :check_out, :number_of_people)
  end
end
