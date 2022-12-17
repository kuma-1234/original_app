require 'rails_helper'

RSpec.describe 'ブログモデル機能', type: :model do
  let!(:user){ FactoryBot.create(:user) }
  let!(:profile){ FactoryBot.build(:profile, user: user) }
  let!(:drone){ FactoryBot.create(:drone, profile: profile) }
  describe 'バリデーションのテスト' do
    context '剤型、散布作物、散布面積、日記帳が入力されている場合' do
      it '日記が作成される' do
        blog = Blog.new(
          pesticide_type: '粒剤', 
          crop: '大豆',
          spray_area: '5',
          content: 'バリデーションのテスト',
          user: user
        )
        expect(blog).to be_valid
      end
    end
    context '剤型が選択されていないとき' do
      it 'バリデーションに引っかかる' do
        blog = Blog.new(
          pesticide_type: '', 
          crop: '稲',
          spray_area: '5',
          content: 'バリデーションのテスト',
          user: user
        )
        expect(blog).not_to be_valid
      end
    end
    context '散布作物が選択されていないとき' do
      it 'バリデーションに引っかかる' do
        blog = Blog.new(
          pesticide_type: '液剤', 
          crop: '',
          spray_area: '5',
          content: 'バリデーションのテスト',
          user: user
        )
        expect(blog).not_to be_valid
      end
    end
    context '散布面積が入力されていないとき' do
      it 'バリデーションに引っかかる' do
        blog = Blog.new(
          pesticide_type: '液剤', 
          crop: '稲',
          spray_area: '',
          content: 'バリデーションのテスト',
          user: user
        )
        expect(blog).not_to be_valid
      end
    end
    context '日記帳が入力されていないとき' do
      it 'バリデーションに引っかかる' do
        blog = Blog.new(
          pesticide_type: '液剤', 
          crop: '稲',
          spray_area: '5',
          content: '',
          user: user
        )
        expect(blog).not_to be_valid
      end
    end
  end
end