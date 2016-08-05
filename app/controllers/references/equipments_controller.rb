class References::EquipmentsController < ApplicationController
  respond_to :json, only: [:index]

  def index
    @equipments = References::Equipment.all
    respond_with @equipments
  end
end
