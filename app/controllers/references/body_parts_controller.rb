class References::BodyPartsController < AnatomicController

  def index
    @body_parts = References::BodyPart.all.eager_load(:exercises, :muscles)
    respond_with @body_parts,
                 each_serializer: request.format == :json && params[:short] ?
                     References::BodyPartShortSerializer :
                     References::BodyPartSerializer
  end

  private

  def resource_params
    accessible = [ :name, :alias, :description, :shape, :muscle_ids => [], :exercise_ids  => [] ]
    params.require(:body_part).permit(accessible)
  end
end
