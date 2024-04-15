class RoomsController < ApplicationController
  before_action :set_users
  before_action :set_room, except: [:new, :create, :index, :show]
  before_action :set_room_users

  def index
    @user_rooms = RoomUser.where(user_id: current_user.id).order("created_at DESC")
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)
    if @room.save
      redirect_to room_posts_path(@room.id)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @room.destroy
    redirect_to root_path
  end

  def show
    #@room = Room.find(params[:id])
    redirect_to room_posts_path(params[:id])
  end

  def edit
  end

  def update
    if @room.update(room_params)
      redirect_to room_path(@room.id)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_room
    @room = Room.find(params[:id])
  end

  def set_room_users
    @room_users = RoomUser.where(room_id: params[:room_id])
  end
  
  def set_users
    @users = User.all
  end

  def room_params
    params.require(:room).permit(:name, :image, user_ids: [])
  end

end