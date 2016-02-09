class PicturesController < ApplicationController
  respond_to :html, :json

  before_action :authenticate_user!
  load_and_authorize_resource except: [:create]
  before_action :load_parent, only: [:index, :create]

  def index
    @pictures = @parent.pictures.all
    respond_with @pictures
  end

  def create
    @picture = Picture.new(resource_params)
    @picture.imageable = @parent
    @picture.save
    respond_with @picture
  end

  def update
    @picture.update(resource_params)
    respond_with @picture
  end

  def destroy
    @picture.destroy!
    respond_with @picture.imageable, @picture
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
