class PicturesController < ApplicationController
  respond_to :html

  before_action :authenticate_user!
  load_and_authorize_resource except: [:create]
  before_action :load_parent, only: [:index]

  def index
    @pictures = @parent.pictures.all
  end

  def destroy
    @picture.destroy!
    redirect_to :back
  end

  private

  def load_parent
    parent_klasses = %w[muscle]
    if klass = parent_klasses.detect { |pk| params[:"#{pk}_id"].present? }
      @parent = klass.camelize.constantize.find params[:"#{klass}_id"]
    end
  end
end
