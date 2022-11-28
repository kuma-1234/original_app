class ApplicationController < ActionController::Base
  #ログイン後のリンクページ
  def after_sign_in_path_for(resource)
    profile_path(resource)
  end

  #ログアウト後のリンクページ
  def after_sign_out_path_for(resource)
    new_user_session_path
  end
end
