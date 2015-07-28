class MusclesController < ApplicationController
  respond_to :html
  before_filter :set_muscle, only: [:show, :edit, :update, :destroy]

  def index
    @muscles = Muscle.all
  end

  def show
  end

  def new
    @muscle = Muscle.new
  end

  def create
    @muscle = Muscle.create(muscle_params)
    respond_with @muscle
  end

  def edit
  end

  def update
    @muscle.update(muscle_params)
    respond_with @muscle
  end

  def destroy
    @muscle.destroy!
    respond_with @muscle
  end

  private

  def set_muscle
    @muscle = Muscle.find(params[:id])
  end

  def muscle_params
    accessible = [ :name, :alias, :description, :shape, :body_part_ids => [], :exercise_ids  => [] ]
    params.require(:muscle).permit(accessible)
  end
end
