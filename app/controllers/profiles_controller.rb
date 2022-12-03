class ProfilesController < ApplicationController

  def edit
    @user = User.find(params[:id])
    @profile = @user.profile
    @profile.drones.build
  end

  def update
    @user = User.find(params[:id])
    @profile = @user.profile
    if @profile.update(params_profile)
      redirect_to profile_path(current_user), notice: 'プロフィールを編集しました'
    else
      render :edit
    end
  end

  def show
    @user = User.find(params[:id])
    @profile = @user.profile
    @drones = @profile.drones
  end

  private 

  def params_profile
    params.require(:profile).permit(:prefecture, :drone_name, :main_crop, :introduce_year, :self_introduce,
                                    drones_attributes: [ :id, :drone_name, :_destroy ])
  end
end
