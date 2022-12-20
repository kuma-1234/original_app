class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  # ログイン済ユーザーのみにアクセスを許可する.
  before_action :authenticate_user!

  # deviseコントローラーにストロングパラメータを追加する      
  before_action :configure_permitted_parameters, if: :devise_controller?

  #ログイン後のリンクページ
  def after_sign_in_path_for(resource)
    profile_path(resource)
  end

  #ログアウト後のリンクページ
  def after_sign_out_path_for(resource)
    new_user_session_path
  end

  protected
  
  def configure_permitted_parameters
    # サインアップ時にname,iconのストロングパラメータを追加
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :icon])
    # profileのストロングパラメータを追加
    devise_parameter_sanitizer.permit(:sign_up, keys: [profile_attributes:[:prefecture]])
    # アカウント編集の時にnameのストロングパラメータを追加
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :icon])
  end
end
