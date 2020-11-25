class RoomsController < ApplicationController

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)
    if @room.valid?
      @room.save
        redirect_to app_tops_path(params[:id])
    else
      render action: :new
    end
  end

  def resource
    
  end

  private

  def room_params
    params.require(:room).permit(:room_num, :floor, :room_status).merge(property_id: params[:id])
  end
end
