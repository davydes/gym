class References::PicturesController < ApplicationController
  respond_to :html, only: [:index]
  respond_to :json

  before_action :authenticate_user!
  authorize_resource
  before_action :load_parent, only: [:index, :show, :create, :destroy]

  def index
    @pictures = @parent.pictures.all
    respond_with @pictures
  end

  def show
    @picture = @parent.pictures.find(params[:id])
    respond_with @picture
  end

  def create
    @picture = Picture.find(params[:l_id])
    @parent.pictures << @picture
    respond_with @picture
  end

  def destroy
    @picture = Picture.find(params[:id])
    @picture = @parent.pictures.delete(@picture)
    respond_with @picture
  end

  private

  def load_parent
    parent_klasses = %w[muscle]
    if klass = parent_klasses.detect { |pk| params[:"#{pk}_id"].present? }
      @parent = "References::#{klass.camelize}".constantize.find params[:"#{klass}_id"]
    end
  end
end
