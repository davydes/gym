class PicturesController < ApplicationController
  respond_to :html, only: [:index]
  respond_to :json

  before_action :authenticate_user!
  load_resource except: [:create]
  authorize_resource
  before_action :load_parent, only: [:index, :create, :destroy]

  def index
    @pictures = @parent.pictures.all
    respond_with @pictures
  end

  def create
    @picture = @parent.pictures.create(resource_params)
    respond_with @picture
  end

  def update
    @picture.update(resource_params)
    respond_with @picture
  end

  def destroy
    @picture.destroy!
    respond_with @parent, @picture
  end

  private

  def load_parent
    parent_klasses = %w[muscle]
    if klass = parent_klasses.detect { |pk| params[:"#{pk}_id"].present? }
      @parent = klass.camelize.constantize.find params[:"#{klass}_id"]
    end
  end

  def resource_params
    accessible = [ :name, :image, :description ]
    params.require(:picture).permit(accessible)
  end
end
