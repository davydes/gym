class References::ExercisesController < AnatomicController

  def index
    @exercises = References::Exercise.all.eager_load(:equipments, :body_parts, :muscles)
    respond_with @exercises,
                 each_serializer: request.format == :json && params[:short] ?
                     References::ExerciseShortSerializer :
                     References::ExerciseSerializer
  end

  private

  def resource_params
    accessible = [ :name, :alias, :description, :body_part_ids => [], :muscle_ids  => [], :equipment_ids  => [] ]
    params.require(:exercise).permit(accessible)
  end
end
