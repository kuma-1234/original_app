class ProfilesController < ApplicationController

  def index
    @profile_q = Profile.includes(:user, :drones).ransack(params[:q])
    @profiles = @profile_q.result(distinct: true).order("created_at desc")
    @profile_q = Profile.ransack
  end

  def edit
    @user = User.find(params[:id])
    if current_user == @user
      @profile = @user.profile
      @profile.drones.build
    else
      redirect_to profile_path(current_user), notice:'他のユーザーは編集できません！'
    end
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
    params.require(:profile).permit(:prefecture, :drone_name, :main_crop, :self_introduce,
                                    drones_attributes: [ :id, :drone_name, :_destroy ])
  end
end
