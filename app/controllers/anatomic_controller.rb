class AnatomicController < ApplicationController
  respond_to :html
  before_filter :set_resource, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except:[:show, :index]

  def index
    objects = model_class.constantize.all
    instance_variable_set("@#{controller_name}", objects)
  end

  def show
  end

  def new
    instance_variable_set "@#{model_class.downcase}", model_class.constantize.new
  end

  def create
    instance_variable_set "@#{model_class.downcase}", model_class.constantize.create(resource_params)
    respond_with instance_variable_get("@#{model_class.downcase}")
  end

  def edit
  end

  def update
    instance_variable_get("@#{model_class.downcase}").update(resource_params)
    respond_with instance_variable_get("@#{model_class.downcase}")
  end

  def destroy
    instance_variable_get("@#{model_class.downcase}").destroy!
    respond_with instance_variable_get("@#{model_class.downcase}")
  end

  private

  def model_class
    controller_name.classify
  end

  def set_resource
    instance_variable_set "@#{model_class.downcase}", model_class.constantize.find(params[:id])
  end

  def resource_params
    accessible = [ :name, :alias, :description ]
    params.require(model_class.downcase.to_sym).permit(accessible)
  end
end
