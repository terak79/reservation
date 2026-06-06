class RoomsController < ApplicationController
  before_action :authenticate_user!, only: [ :new, :create ]
  before_action :set_room, only: [ :show ]

  def index
    @rooms = Room.all
    if params[:keyword].present?
      @rooms = @rooms.where("name LIKE ? OR description LIKE ?", "%#{params[:keyword]}%", "%#{params[:keyword]}%")
    end
    if params[:area].present?
      @rooms = @rooms.where("address LIKE ?", "%#{params[:keyword]}%")
    end
  end

  def show
  end

  def new
    @room = Room.new
  end

  def create
    @room = current_user.rooms.build(room_params)
    if @room.save
      redirect_to @room, notice: "施設を登録しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_room
    @room = Room.find(params[:id])
  end

  def room_params
    params.require(:room).permit(:name, :description, :price, :address, :image)
  end
end
