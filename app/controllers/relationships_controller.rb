class RelationshipsController < ApplicationController

  before_action :authenticate_user!

  def create
    @profile = Profile.find(params[:relationship][:followed_id])
    current_user.profile.follow!(@profile)
  end

  def destroy
    @profile = Relationship.find(params[:id]).followed
    current_user.profile.unfollow!(@profile)
  end
end
