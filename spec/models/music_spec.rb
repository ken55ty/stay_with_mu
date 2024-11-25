require 'rails_helper'

RSpec.describe Music, type: :model do
  describe 'バリデーション' do
    let(:user) { create(:user) }

    describe 'すべての属性が有効な場合' do
      it '有効であること' do
        music = build(:music, user:, title: '正しいタイトル', spotify_track_id: '2lyhLZisQc9XXHSREtCa74')

        expect(music).to be_valid
      end
    end

    describe 'titleのバリデーション' do
      context 'titleが空の場合' do
        it '無効であること' do
          music = build(:music, user:, title: '')

          expect(music).not_to be_valid
          expect(music.errors[:title]).to include("を入力してください")
        end
      end

      context 'titleが存在する場合' do
        it '有効であること' do
          music = build(:music, user:, title: '有効なタイトル')

          expect(music).to be_valid
        end
      end
    end

    describe 'spotify_track_idのバリデーション' do
      context 'spotify_track_idが同じ場合' do
        before do
          create(:music, user:, spotify_track_id: '2lyhLZisQc9XXHSREtCa74')
        end

        it '同じユーザーが同じspotify_track_idの曲を登録できないこと' do
          music = build(:music, user:, spotify_track_id: '2lyhLZisQc9XXHSREtCa74')

          expect(music).not_to be_valid
          expect(music.errors[:spotify_track_id]).to include('はすでに存在します')
        end

        it '別のユーザーが同じspotify_track_idの曲を登録できること' do
          another_user = create(:user)
          music = build(:music, user: another_user, spotify_track_id: '2lyhLZisQc9XXHSREtCa74')

          expect(music).to be_valid
        end
      end

      context 'spotify_track_idが異なる場合' do
        it '同じユーザーが異なるspotify_track_idの曲を登録できること' do
          create(:music, user:, spotify_track_id: '2lyhLZisQc9XXHSREtCa74')
          music = build(:music, user:, spotify_track_id: '5tVA6TkbaAH9QMITTQRrNv')

          expect(music).to be_valid
        end
      end
    end
  end
end
