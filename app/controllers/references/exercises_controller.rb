class References::ExercisesController < AnatomicController

  def index
    @exercises = References::Exercise.all
    respond_with @exercises, each_serializer: References::ExerciseShortSerializer
  end

  private

  def resource_params
    accessible = [ :name, :alias, :description, :body_part_ids => [], :muscle_ids  => [], :equipment_ids  => [] ]
    params.require(:exercise).permit(accessible)
  end
end
