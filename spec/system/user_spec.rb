require 'rails_helper'

RSpec.feature 'ユーザー管理機能',  type: :system do
  describe 'ユーザーの新規登録テスト' do
    context '新規登録ができる場合' do
      it 'ユーザーの新規登録ができて、マイページを表示する' do
        visit new_user_registration_path
        fill_in 'user[name]', with: 'user1'
        select '北海道', from: 'user[profile_attributes][prefecture]'
        fill_in 'user[email]', with: 'test1@test.com'
        fill_in 'user[password]', with: 'user01'
        fill_in 'user[password_confirmation]', with: 'user01'
        click_on 'アカウント登録'
        expect(page).to have_content 'user1'
      end
    end
    context 'ユーザー登録をしていない場合' do
      it 'ユーザー登録をせずに投稿一覧画面に移行しようとした場合、ログイン画面に戻ってくる' do
        visit blogs_path
        expect(current_path).to eq new_user_session_path
      end
    end
  end
end