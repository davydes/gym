class References::BodyPartsController < AnatomicController
  private

  def resource_params
    accessible = [ :name, :alias, :description, :shape, :muscle_ids => [], :exercise_ids  => [] ]
    params.require(:body_part).permit(accessible)
  end
end
