class References::ExercisesController < AnatomicController
  private

  def resource_params
    accessible = [ :name, :alias, :description, :body_part_ids => [], :muscle_ids  => [] ]
    params.require(:exercise).permit(accessible)
  end
end
