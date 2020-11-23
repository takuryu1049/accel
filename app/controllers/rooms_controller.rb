class RoomsController < ApplicationController

  def new
    @property = Property.find(params[:id])
  end

end
