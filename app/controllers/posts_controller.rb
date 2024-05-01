class PostsController < ApplicationController
  before_action :set_room
  before_action :set_room_users


  def index
    @posts = @room.posts.includes(:user)
    @room_user = RoomUser.find(params[:room_id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to room_posts_path(@room.id)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to room_posts_path(@room.id)
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @comments = @post.comments.includes(:user).order("created_at DESC")
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to room_post_path(@room.id), notice: "編集しました"
    else
      render 'edit'
    end
  end


  private

  def set_room
    @room = Room.find(params[:room_id])
  end

  def set_room_users
    @room_users = RoomUser.where(room_id: params[:room_id])
  end

  def post_params
    params.require(:post).permit(:title, :type_id, :date, :start_time, :end_time, :content, :image)
    .merge(user_id: current_user.id, room_id: params[:room_id])
  end

end
