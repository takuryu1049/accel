class RoomsController < ApplicationController

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)
    # 登録制限の為に現在の物件数を取得
    property_rooms = Property.find(params[:id]).rooms.count
    # 登録制限の為に、物件の情報を取得
    property_units = Property.find(params[:id]).units
    if property_rooms >= property_units
      flash[:notice] = '部屋数が上限に達しています！'
      redirect_to property_path(params[:id], anchor: 'rooom-create-anchor')
    else
      if @room.valid?
        @room.save
        flash[:notice] = '部屋登録が完了しました！'
        redirect_to property_path(params[:id], anchor: 'rooom-create-anchor')
      else
        render action: :new
      end
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
