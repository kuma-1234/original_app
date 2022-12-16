# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :ensure_normal_user, only: :destroy

  def ensure_normal_user
    if resource.email == 'guest@example.com' || resource.email == 'guest_admin@example.com'
      redirect_to profile_path(current_user), alert: 'ゲストユーザーは削除できません。'
    end
  end

  # GET /resource/sign_up
  def new
    @user = User.new
    #user作成時にprofileを作成する
    @profile = @user.build_profile
  end

  protected
  # アカウント編集後、プロフィール画面に移動する
  def after_update_path_for(resource)
    profile_path(current_user)
  end
  #ログイン後にマイページへ
  def after_sign_up_path_for(resource)
    profile_path(resource)
  end
end
