require 'rails_helper'

RSpec.feature 'プロフィール管理機能',  type: :system do
  let!(:user){ FactoryBot.create(:user) }
  let!(:profile){ FactoryBot.build(:profile, user: user) }
  let!(:drone){ FactoryBot.create(:drone, profile: profile) }
  let!(:user2){ FactoryBot.create(:user2) }
  let!(:profile2){ FactoryBot.build(:profile2, user: user2) }
  let!(:drone2){ FactoryBot.create(:drone2, profile: profile2) }

  def login_1
    visit new_user_session_path
    fill_in 'user[email]', with: 'guest@test.com'
    fill_in 'user[password]', with:'guest123456'
    click_button 'ログイン'
  end

  def login_2
    visit new_user_session_path
    fill_in 'user[email]', with: 'gues2t@test.com'
    fill_in 'user[password]', with: 'guest123456'
    click_button 'ログイン'
  end

  describe 'プロフィールの編集テスト' do
    before do
      login_1
    end
    context 'プロフィールを編集した場合' do
      it 'マイページに更新されたものが反映される' do
        click_on 'プロフィール設定'
        visit edit_profile_path(user)
        select '秋田県', from: 'profile[prefecture]'
        fill_in 'profile[drones_attributes][0][drone_name]', with: 'ABC'
        fill_in 'profile[main_crop]', with: 'たけのこ'
        fill_in 'profile[self_introduce]', with: 'おはよう'
        click_on 'プロフィール設定を更新'
        expect(current_path).to eq profile_path(profile)
        expect(page).to have_content 'ABC'
        expect(page).to have_content '秋田県'
        expect(page).not_to have_content '北海道'
      end
    end
    context '他のユーザーのマイページを編集しようとした場合' do
      it '編集はできずに、自分のマイページにリダイレクトする' do
        visit edit_profile_path(user2)
        expect(current_path).to eq profile_path(user)
        expect(page).to have_content '他のユーザーは編集できません！'
      end
    end
  end
end