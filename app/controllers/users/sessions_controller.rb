# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to blogs_path, notice: 'ゲストユーザーとしてログインしました'
  end

  def guest_admin_sign_in
    user = User.guest_admin
    sign_in user
    redirect_to blogs_path, notice:'管理者といてログインしました'
  end
end
