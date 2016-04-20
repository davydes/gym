class PicturesController < ApplicationController
  respond_to :json

  before_action :authenticate_user!
  load_resource except: [:create]
  authorize_resource

  def index
    if params[:obj_type] && params[:obj_id]
      @pictures = Picture.for_obj(params[:obj_type], params[:obj_id])
    else
      @pictures = Picture.all
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
