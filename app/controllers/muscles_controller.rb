class MusclesController < AnatomicController
  private

  def resource_params
    accessible = [ :name, :alias, :description, :shape, :body_part_ids => [], :exercise_ids  => [] ]
    params.require(:muscle).permit(accessible)
  end
end
