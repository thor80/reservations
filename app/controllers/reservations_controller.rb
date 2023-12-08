class ReservationsController < ApplicationController
  def index
    if current_user
      @reservations = current_user.reservations
    else
      redirect_to root_path
    end
  end

  def new
    if current_user
      @room = Room.find(params[:room_id])
      @reservation = Reservation.new
    else
      redirect_to root_path
    end
  end

  def create
    if current_user
      @room = Room.find(params[:room_id])
      @reservation = Reservation.new(create_params)
      @reservation.user = current_user
      @reservation.room = @room

      if @reservation.save
        flash[:notice] = "Room created successfully"
        redirect_to list_user_reservations_path(current_user.id)
      else
        flash[:alert] = "Room not created"
        render :new, status: :unprocessable_entity
      end
    else
      redirect_to root_path
    end
  end

  private

  def new_params
    params.permit(:room_id)
  end

  def create_params
    params.require(:reservation).permit(:check_in, :check_out, :people)
  end
end
