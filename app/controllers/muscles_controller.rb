class MusclesController < AnatomicController

  def index
    @body_parts = BodyPart.with_muscles.order(:name)
    @muscles = Muscle.no_bodypart
  end

  private

  def resource_params
    accessible = [ :name, :alias, :description, :shape, :body_part_ids => [], :exercise_ids  => [] ]
    params.require(:muscle).permit(accessible)
  end
end
