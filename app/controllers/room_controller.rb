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

  def search
    if current_user
      area_where_sentences = []
      free_text_where_sentences = []
      text_search = params[:text_search]
      areas = params[:areas]


      if areas
        for area in areas
          area_where_sentences << "lower(address) like '%" + area.downcase + "%'"
        end
      end

      if text_search
        for word in text_search.split(/\W+/)
          free_text_where_sentences << "lower(name) like '%" + word.downcase + "%' or lower(introduction) like '%" + word.downcase + "%'"
        end
      end

      conditions = nil
      if area_where_sentences.length() > 0 && free_text_where_sentences.length() > 0
        conditions = "(" + area_where_sentences.join(" or ") + ") and (" + free_text_where_sentences.join(" or ") + ")"
      elsif area_where_sentences.length() > 0
        conditions = area_where_sentences.join(" or ")
      elsif free_text_where_sentences.length() > 0
          conditions = free_text_where_sentences.join(" or ")
      end

      if conditions
        @rooms = Room.where(conditions)
      end

      @text_search = text_search
      @areas = areas
      @conditions = conditions

    else
      redirect_to root_path
    end
  end

  def details
    if current_user
      @room = Room.find(params[:id])
    else
      redirect_to root_path
    end
  end

  private

  def room_params
    params.require(:room).permit(:name, :introduction, :address, :fee, :image)
  end

  def search_params
    params.permit(:text_search, :areas)
  end

  def view_room_params
    params.permit(:id)
  end

end
