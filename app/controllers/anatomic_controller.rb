class AnatomicController < ApplicationController
  respond_to :html
  before_action :authenticate_user!, except:[:show, :index]
  load_and_authorize_resource except: [:create]

  def index
    objects = model_class.constantize.all
    instance_variable_set("@#{controller_name}", objects)
  end

  def show
  end

  def new
    instance_variable_set "@#{model_class.underscore}", model_class.constantize.new
  end

  def create
    instance_variable_set "@#{model_class.underscore}", model_class.constantize.create(resource_params)
    respond_with instance_variable_get("@#{model_class.underscore}")
  end

  def edit
  end

  def update
    instance_variable_get("@#{model_class.underscore}").update(resource_params)
    respond_with instance_variable_get("@#{model_class.underscore}")
  end

  def destroy
    instance_variable_get("@#{model_class.underscore}").destroy!
    respond_with instance_variable_get("@#{model_class.underscore}")
  end

  private

  def model_class
    controller_name.classify
  end

  def resource_params
    accessible = [ :name, :alias, :description ]
    params.require(model_class.underscore.to_sym).permit(accessible)
  end
end
