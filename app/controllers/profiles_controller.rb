class ProfilesController < ApplicationController
  before_action :set_profile, only: %i[show edit update]

  def show; end

  def update
    if @profile.update(profile_params)
      redirect_to profile_path
    else
      render profile_path(@profile)
    end
  end

  private

  def profile_params
    params.require(:user).permit(
      :name,
      :phone_number,
      :avatar
    )
  end

  def set_profile
    @profile = current_user
  end
end
