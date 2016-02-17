class MusclesController < AnatomicController
  def index
    @body_parts = BodyPart.with_muscles.order(:name)
    @muscles = Muscle.no_bodypart
    respond_with Muscle.all
  end

  private

  def resource_params
    accessible = [ :name, :alias, :description, :shape, :body_part_ids => [], :exercise_ids  => [], :pictures_attributes => [] ]
    params.require(:muscle).permit(accessible)
  end
end
