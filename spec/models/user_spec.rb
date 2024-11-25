require 'rails_helper'

RSpec.describe User, type: :model do
  it '名前、メールがあり、パスワードは3文字以上であれば有効であること' do
    user = build(:user)
    expect(user).to be_valid
  end

  it 'メールはユニークであること' do
    user1 = create(:user)
    user2 = build(:user)
    user2.email = user1.email
    user2.valid?
    expect(user2.errors[:email]).to include('はすでに存在します')
  end

  it 'メールアドレス名前は必須項目であること' do
    user = build(:user)
    user.email = nil
    user.name = nil
    user.valid?
    expect(user.errors[:email]).to include('を入力してください')
    expect(user.errors[:name]).to include('を入力してください')
  end

  it '名前は255文字以下であること' do
    user = build(:user)
    user.name = 'a' * 256
    user.valid?
    expect(user.errors[:name]).to include('は20文字以内で入力してください')
  end
end
