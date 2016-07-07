class References::MusclesController < AnatomicController
  def index
    @body_parts = References::BodyPart.with_muscles.order(:name)
    @muscles = References::Muscle.no_bodypart
    respond_with References::Muscle.all
  end

  private

  def resource_params
    accessible = [ :name, :alias, :description, :shape, :body_part_ids => [], :exercise_ids  => [], :pictures_attributes => [] ]
    params.require(:muscle).permit(accessible)
  end
end
