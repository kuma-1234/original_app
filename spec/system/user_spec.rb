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
  
  describe 'ログイン機能のテスト' do
    before do
      @user = FactoryBot.create(:user)
      @user2 = FactoryBot.create(:user2)
      @profile = FactoryBot.create(:profile, user: @user)
    end
    context 'ログインしていない場合' do
      it 'ログインしてマイページへ移動する' do
        visit new_user_session_path
        fill_in 'user[email]', with: 'guest@test.com'
        fill_in 'user[password]', with:  'guest123456'
        click_button 'ログイン'
        expect(current_path).to eq profile_path(@user.id)
      end
    end
    context 'ログインしている場合' do
      before do
        visit new_user_session_path
        fill_in 'user[email]', with: @user.email
        fill_in 'user[password]', with: @user.password
        click_button 'ログイン'
      end
      it 'マイページに移動する' do
        expect(current_path).to eq profile_path(@user.id)
      end
      it 'マイページにアクセスしているユーザーが本人であればアカウント設定ができる' do
        visit profile_path(@user.id)
        expect(page).to have_content 'アカウント設定'
      end
      it 'マイページにアクセスしているユーザーが他人であればアカウント設定はできない' do
        visit profile_path(@user2.id)
        expect(page).not_to have_content 'アカウント設定'
      end
      it 'ログアウトができる' do
        click_on 'ログアウト'
        expect(current_path).to eq new_user_session_path
      end
    end
  end
end