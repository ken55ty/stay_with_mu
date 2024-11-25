require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーション' do
    context 'すべての属性が正しい場合' do
      it '有効であること' do
        user = build(:user)
        expect(user).to be_valid
      end
    end

    context 'メールアドレスのバリデーション' do
      it 'メールはユニークであること' do
        user1 = create(:user)
        user2 = build(:user)
        user2.email = user1.email
        user2.valid?
        expect(user2.errors[:email]).to include('はすでに存在します')
      end

      it 'メールアドレスが空の場合、無効であること' do
        user = build(:user)
        user.email = nil
        user.valid?
        expect(user.errors[:email]).to include('を入力してください')
      end
    end

    context '名前のバリデーション' do
      it '名前が空の場合、無効であること' do
        user = build(:user)
        user.name = nil
        user.valid?
        expect(user.errors[:name]).to include('を入力してください')
      end

      it '名前が20文字を超える場合、無効であること' do
        user = build(:user)
        user.name = 'a' * 256
        user.valid?
        expect(user.errors[:name]).to include('は20文字以内で入力してください')
      end
    end
  end
end
