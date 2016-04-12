class PicturesController < ApplicationController
  respond_to :json

  before_action :authenticate_user!
  load_resource except: [:create]
  authorize_resource

  def index
    @pictures = Picture.all
    if params[:obj_type] && params[:obj_id]
      object = params[:obj_type].classify.constantize.find(params[:obj_id])
      @pictures = @pictures - object.pictures
    end
    respond_with @pictures
  end

  def create
    @picture = Picture.create(resource_params)
    respond_with @picture
  end

  def update
    @picture.update(resource_params)
    respond_with @picture
  end

  def destroy
    @picture.destroy!
    respond_with @picture
  end

  private

  def resource_params
    accessible = [ :name, :image, :description ]
    params.require(:picture).permit(accessible)
  end
end
