require 'rails_helper'
RSpec.describe 'ユーザー管理機能', type: :model do
  describe 'バリデーションのテスト' do
    context '名前、メールアドレス、パスワードの情報が正しく入力されている場合' do
      it 'アカウント登録が完了する' do
        user = User.new(name: 'user', email: 'guest@test.com', password: 'pass123456', password_confirmation: 'pass123456')
        expect(user).to be_valid
      end
    end
    context '名前、メールアドレス、パスワードのいずれかの情報が入力されていない場合' do
      it 'バリデーションに引っかかりアカウント登録ができない' do
        user1 = User.new(name: '', email: 'guest@example.com', password: 'pass123456', password_confirmation: 'pass123456')
        user2 = User.new(name: 'user2', email: '', password: 'pass123456', password_confirmation: 'pass123456')
        user3 = User.new(name: 'user3', email: 'guest3@example.com', password: '', password_confirmation: 'pass123456')
        user4 = User.new(name: 'user4', email: 'guest4@example.com', password: 'pass123456', password_confirmation: '')
        expect(user1).not_to be_valid
        expect(user2).not_to be_valid
        expect(user3).not_to be_valid
        expect(user4).not_to be_valid
      end
    end
  end
end