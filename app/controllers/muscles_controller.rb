class MusclesController < AnatomicController
  after_filter :save_pictures, only: [:create, :update]

  def index
    @body_parts = BodyPart.with_muscles.order(:name)
    @muscles = Muscle.no_bodypart
  end

  private

  def resource_params
    accessible = [ :name, :alias, :description, :shape, :body_part_ids => [], :exercise_ids  => [], :pictures_attributes => [] ]
    params.require(:muscle).permit(accessible)
  end

  def save_pictures
    if @muscle.save && params[:pictures]
      params[:pictures]['image'].each do |a|
        @picture = @muscle.pictures.create!(:name => a.original_filename, :image => a)
      end
    end
  end
end
