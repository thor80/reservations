class RoomController < ApplicationController
  def index
    if current_user
      @rooms = current_user.rooms
    else
      redirect_to root_path
    end
  end

  def view
    @room = Room.find(params[:room_id])
  end

  def new
    @room = Room.new
  end

  def create
    if current_user
      @room = Room.new(room_params)
      @room.user = current_user

      if @room.save
        flash[:notice] = "Room created successfully"
        redirect_to user_rooms_path(current_user.id)
      else
        flash[:alert] = "Room not created"
        render :new, status: :unprocessable_entity
      end
    else
      redirect_to root_path
    end
  end

  def edit
    if current_user
    else
      redirect_to root_path
    end
  end

  private

  def room_params
    params.require(:room).permit(:name, :introduction, :fee, :address, :prefecture, :postcode, :city, :image)
  end

end
