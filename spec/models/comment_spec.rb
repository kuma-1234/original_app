require 'rails_helper'

RSpec.describe 'コメントモデル機能', type: :model do
  let!(:user){ FactoryBot.create(:user) }
  let!(:profile){ FactoryBot.build(:profile, user: user) }
  let!(:drone){ FactoryBot.create(:drone, profile: profile) }
  let!(:blog){ FactoryBot.create(:blog,user: user) }
  describe 'バリデーションのテスト' do
    context 'talkが入力されている場合' do
      it 'コメントが作成される' do
        comment = Comment.new(
          talk: 'こんにちは',
          user: user,
          blog: blog
        )
        expect(comment).to be_valid
      end
    end
    context 'talkが入力されていない場合' do
      it 'バリデーションに引っかかる' do
        comment = Comment.new(
          talk: '',
          user: user,
          blog: blog
        )
        expect(comment).not_to be_valid
      end
    end
  end
end