class MusclesController < AnatomicController

  def index
    @body_parts = BodyPart.joins(:muscles).group('body_parts.id').having('count( body_part_id ) > 0').order(:name)
  end

  private

  def resource_params
    accessible = [ :name, :alias, :description, :shape, :body_part_ids => [], :exercise_ids  => [] ]
    params.require(:muscle).permit(accessible)
  end
end
