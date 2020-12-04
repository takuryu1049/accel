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
    @resource = Resource.new
  end

  def resource_create
    @resource = Resource.new(resource_params)
    if @resource.valid?
        @resource.save
        redirect_to property_path(params[:id])
    else
      render action: :resource
    end
  end

  private

  def room_params
    params.require(:room).permit(:room_num, :floor, :room_status).merge(property_id: params[:id])
  end

  def resource_params
    params.require(:resource).permit(:brokerage_fee, :ad_fee)
  end

end
