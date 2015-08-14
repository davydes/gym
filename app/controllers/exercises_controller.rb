class ExercisesController < ApplicationController
  respond_to :html
  before_filter :set_exercise, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except:[:show, :index]

  def index
    @exercises = Exercise.all
  end

  def show
  end

  def new
    @exercise = Exercise.new
  end

  def create
    @exercise = Exercise.create(exercise_params)
    respond_with @exercise
  end

  def edit
  end

  def update
    @exercise.update(exercise_params)
    respond_with @exercise
  end

  def destroy
    @exercise.destroy!
    respond_with @exercise
  end

  private

  def set_exercise
    @exercise = Exercise.find(params[:id])
  end

  def exercise_params
    accessible = [ :name, :alias, :description, :body_part_ids => [], :muscle_ids  => [] ]
    params.require(:exercise).permit(accessible)
  end
end
