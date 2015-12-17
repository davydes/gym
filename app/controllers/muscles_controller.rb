class MusclesController < AnatomicController

  def create
    @muscle = Muscle.new(resource_params)
    params[:pictures]['image'].each do |i|
      @picture = @muscle.pictures.create!(:image => i)
    end if @muscle.save
    respond_with @muscle
  end

  def index
    @body_parts = BodyPart.with_muscles.order(:name)
    @muscles = Muscle.no_bodypart
  end

  private

  def resource_params
    accessible = [ :name, :alias, :description, :shape, :body_part_ids => [], :exercise_ids  => [], pictures_attributes: [:image] ]
    params.require(:muscle).permit(accessible)
  end
end
