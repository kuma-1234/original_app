require 'rails_helper'

RSpec.describe 'ブログ管理機能', type: :system do
  let!(:user){ FactoryBot.create(:user) }
  let!(:profile){ FactoryBot.build(:profile, user: user) }
  let!(:drone){ FactoryBot.create(:drone, profile: profile) }
  let!(:blog){ FactoryBot.create(:blog,user: user) }
  let!(:blog2){ FactoryBot.create(:blog2,user: user) }
  let!(:blog3){ FactoryBot.create(:blog3,user: user) }
  let!(:user2){ FactoryBot.create(:user2) }
  let!(:profile2){ FactoryBot.build(:profile2, user: user2) }
  let!(:drone2){ FactoryBot.create(:drone2, profile: profile2) }
  let!(:blog4){ FactoryBot.create(:blog4,user: user2) }
  let!(:blog5){ FactoryBot.create(:blog5,user: user2) }

  def login
    visit new_user_session_path
    fill_in 'user[email]', with: 'guest@test.com'
    fill_in 'user[password]', with:'guest123456'
    click_button 'ログイン'
  end

  describe '新規投稿機能' do
    context '日記を新規作成した場合' do
      it '新規投稿した日記が一覧画面に表示される' do
        login
        visit new_blog_path
        select '液剤（肥料）', from:'blog[pesticide_type]'
        select '大豆', from:'blog[crop]'
        fill_in 'blog[spray_area]', with: '2'
        fill_in 'blog[content]', with: 'こちらはテストです'
        click_on '作成'
        expect(page).to have_content 'こちらはテストです'
      end
      it '新規投稿した日記が一覧画面に表示されない（非公開選択時）' do
        login
        visit new_blog_path
        select 'その他', from:'blog[pesticide_type]'
        select '稲', from:'blog[crop]'
        fill_in 'blog[spray_area]', with: '2'
        fill_in 'blog[content]', with: 'これはテストです'
        choose '非公開(自分にのみ表示されます)'
        click_on '作成'
        expect(page).not_to have_content 'これはテストです'
      end
    end
  end

  describe '一覧表示機能' do
    context 'みんなの投稿に移動した場合' do
      it '公開している日記のみ表示される' do
        login
        visit blogs_path
        expect(page).to have_content 'テストテスト'
        expect(page).not_to have_content 'カキクケコ'
      end
    end
    context '自分の投稿一覧画面に移動した場合' do
      it '非公開にしている日記も全て表示される' do
        login
        visit yourself_blog_blogs_path(user)
        expect(page).to have_content 'テストテスト'
        expect(page).to have_content 'カキクケコ'
      end
    end
    context '他のユーザーの投稿一覧画面に移動した場合' do
      it '公開にしている記事のみ表示される' do
        login
        visit other_blog_blog_path(user2)
        expect(page).to have_content 'サシスセソ'
        expect(page).not_to have_content 'タチツテト'
      end
    end
  end
  describe '詳細表示機能' do
    context '任意の日記の詳細画面に移動した場合' do
      it '日記の詳細が表示される' do
        login
        visit blog_path(blog)
        expect(page).to have_content '919'
      end
      it 'コメントの投稿が出来きる' do
        login
        visit blog_path(blog4)
        fill_in 'comment[talk]', with: 'こんにちは'
        click_on 'コメント投稿'
        expect(page).to have_content 'こんにちは'
      end
    end
  end
  describe '日記編集機能' do
    context '任意の日記の編集画面に移動した場合' do
      it '日記の編集ができる（日記作成者が自分の場合）' do
        login
        visit edit_blog_path(blog)
        fill_in 'blog[content]', with: 'おはようございます'
        click_on '作成'
        expect(page).to have_content 'おはようございます'
        expect(page).not_to have_content 'テストテスト'
      end
      it '他のユーザーの日記を編集しようとした場合みんなの投稿画面に移動する' do
        login
        visit edit_blog_path(blog4)
        expect(current_path).to eq blogs_path
      end
    end
  end
  describe '削除機能' do
    context '任意の日記の削除をしようとした場合' do
      it '作成者が自分の場合削除できる' do
        login
        visit blogs_path
        click_on '削除', match: :first
        expect(page.accept_confirm).to eq "本当に削除しても良いですか？"
        expect(page).to have_content 'ブログを削除しました！'
        expect(page).not_to have_content 'アイウエオ'
      end
    end
  end
  describe '検索機能' do
    before do
      login
      visit blogs_path
    end
    context '機体名であいまい検索をした場合' do
      it '検索ワードを含む日記で絞り込まれる' do
        fill_in 'q[drones_drone_name_cont]', with: 'A'
        click_on '検索'
        expect(page).not_to have_content 'A'
      end
    end
    context '剤型で検索をした場合' do
      it '剤型に一致した日記に絞り込まれる' do
        choose 'q_pesticide_type_eq_1'
        click_on '検索'
        expect(page).to have_content 'アイウエオ'
        expect(page).to have_content 'サシスセソ'
        expect(page).not_to have_content 'カキくケコ'
      end
    end
    context '農薬名で検索をした場合' do
      it '検索ワードを含む日記で絞り込まれる' do
        fill_in 'q[pesticide_name_cont]', with: '1キロ粒剤'
        click_on '検索'
        expect(page).to have_content 'テストテスト'
        expect(page).not_to have_content 'カキくケコ'
      end
    end
    context '作物で検索をした場合' do
      it "作物に完全一致したタスクが絞り込まれる" do
        select '稲', from: 'q[crop_eq]'
        click_on '検索'
        expect(page).to have_content 'アイウエオ'
        expect(page).not_to have_content 'テストテスト'
      end
    end
    context '品種名で検索をした場合' do
      it '検索ワードを含む日記で絞り込まれる' do
        fill_in 'q[variety_cont]', with: 'フクユタカ'
        click_on '検索'
        expect(page).to have_content 'サシスセソ'
        expect(page).not_to have_content 'アイウエオ'
      end
    end
    context '日記帳のキーワードで検索をした場合' do
      it '検索ワードを含む日記で絞り込まれる' do
        fill_in 'q[content_cont]', with: 'サシス'
        click_on '検索'
        expect(page).to have_content 'サシスセソ'
        expect(page).not_to have_content 'アイウエオ'
      end
    end
  end
end