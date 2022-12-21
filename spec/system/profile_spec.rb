require 'rails_helper'

RSpec.feature 'プロフィール管理機能', type: :system do
  let!(:user) { FactoryBot.create(:user) }
  let!(:profile) { FactoryBot.build(:profile, user: user) }
  let!(:drone) { FactoryBot.create(:drone, profile: profile) }
  let!(:user2) { FactoryBot.create(:user2) }
  let!(:profile2) { FactoryBot.build(:profile2, user: user2) }
  let!(:drone2) { FactoryBot.create(:drone2, profile: profile2) }
  let!(:admin_user) { FactoryBot.create(:admin_user) }
  let!(:profile3) { FactoryBot.build(:profile3, user: admin_user) }
  let!(:drone3) { FactoryBot.create(:drone3, profile: profile3) }

  def login_1
    visit new_user_session_path
    fill_in 'user[email]', with: 'guest@test.com'
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
  describe '登録ユーザーの一覧画面機能' do
    before do
      login_1
    end
    context '登録ユーザー一覧画面に移動した場合' do
      it '登録しているユーザー全てが確認できる' do
        visit profiles_path
        expect(page).to have_content 'guest'
        expect(page).to have_content 'guest2'
      end
    end
  end
  describe '登録ユーザーの一覧画面検索機能' do
    before do
      login_1
    end
    context '機体名で検索した場合' do
      it 'その機体を所有しているユーザーのみ表示される' do
        visit profiles_path
        fill_in 'q[drones_drone_name_cont]', with: 'A'
        click_on '検索'
        expect(page).to have_content 'A'
        expect(page).to have_content 'guest'
        expect(page).not_to have_content 'admin_user'
      end
    end
    context '作物名で検索した場合' do
      it 'その作物を生産しているユーザーのみ表示される' do
        visit profiles_path
        fill_in 'q[main_crop_cont]', with: 'さとうきび'
        click_on '検索'
        expect(page).to have_content 'guest2'
        expect(page).not_to have_content 'admin_user'
      end
    end
    context '作物名で検索した場合' do
      it 'その作物を生産しているユーザーのみ表示される' do
        visit profiles_path
        select '新潟県', from: 'q[prefecture_eq]'
        click_on '検索'
        expect(page).to have_content 'admin_user'
        expect(page).not_to have_content 'guest2'
      end
    end
  end
end