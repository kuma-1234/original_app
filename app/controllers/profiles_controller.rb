class ProfilesController < ApplicationController

  def edit
    @profile = Profile.find(params[:id])
  end

  def update
    @profile = Profile.find(params[:id])
    if @profile.update(params_profile)
      redirect_to profile_path(current_user), notice: 'プロフィールを編集しました'
    else
      render :edit
    end
  end

  def show
    @profile = Profile.find(params[:id])
  end

  private 

  def params_profile
    params.require(:profile).permit(:prefecture, :drone_name, :main_crop, :introduction_year, :self_introduction)
  end


end
