class ProfilesController < ApplicationController
  skip_before_filter :require_user_profile, only: [:edit, :update]
  respond_to :html
  load_and_authorize_resource find_by: :name

  def index
  end

  def show
  end

  def update
    @profile.update_attributes(resource_params)
    respond_with @profile, location: -> { profile_path @profile }
  end

  # GET /profile
  # Current user profile
  def current
    @profile = current_user.profile
  end
  
  private

  def resource_params
    params.require(:profile).permit(:name)
  end
end
