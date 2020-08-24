require 'rails_helper'

RSpec.describe Exercise, type: :model do
  let(:exercise) { create(:exercise)}

   # 部位、レベル、URLがあり有効なファクトリを持つこと
   it "has a valid factory" do
    expect(build(:exercise)).to be_valid
  end

  # 存在性チェック
  describe "test of presence" do
    #  部位がなければ無効な状態であること
    it "is invalid without a part" do
      exercise.part = nil
      exercise.valid?
      expect(exercise.errors[:part]).to include("を入力してください")
    end

    # レベルがなければ無効な状態であること
    it "is invalid without a level" do
      exercise.level = nil
      exercise.valid?
      expect(exercise.errors[:level]).to include("を入力してください")
    end

    # urlがなければ無効な状態であること
    it "is invalid without an url" do
      exercise.url = nil
      exercise.valid?
      expect(exercise.errors[:url]).to include("を入力してください")
    end

    # user_idがなければ無効な状態であること
    it "is invalid without an user_id" do
      exercise.user_id = nil
      exercise.valid?
      expect(exercise.errors.full_messages).to include("Userを入力してください")
    end
  end

  # 部位
  describe "part" do
    # 有効パターン
    context "valid entry" do
      ['二の腕', 'お腹', '胸', '足'].each do |valid_part|
        # 二の腕、お腹、胸、足は有効であること
        it "is valid with #{valid_part}" do
          expect(build(:exercise, part: valid_part)).to be_valid
        end
      end
    end
    # 無効パターン
    context "invalid entry" do
      # 二の腕、お腹、胸、以外は無効であること
      it "is invalid without 二の腕, お腹, 胸, 足" do
        exercise.part = "a"
        exercise.valid?
        expect(exercise.errors[:part]).to include("は一覧にありません")
      end
    end
  end

  # level
  describe "level" do
    # 有効パターン
    context "valid entry" do
      [1, 2, 3].each do |valid_level|
        # 1,2,3は有効であること
        it "is valid with #{valid_level}" do
          expect(build(:exercise, level: valid_level)).to be_valid
        end
      end
    end
    # 無効パターン
    context "invalid entry" do
      # 1,2,3以外は無効であること
      it "is invalid without 1,2,3" do
        exercise.level = 4
        exercise.valid?
        expect(exercise.errors[:level]).to include("は一覧にありません")
      end
    end
  end

  # urlの正規表現
  describe "regex of url" do
    #有効パターン
    context "valid entry" do

      # PC版のYouTubeURLは有効であること
      it "is valid with a url which pc" do
        exercise.url = "https://www.youtube.com/watch?v=aaaaaaaaaaa"
        expect(exercise).to be_valid
      end

      # スマホ版のYouTubeURLは有効であること
      it "is valid with a url which smart phone" do
        exercise.url = "https://youtu.be/aaaaaaaaaaa"
        expect(exercise).to be_valid
      end
    end
    # 無効パターン
    context "invalit entry" do
      valid_url = "YouTubeのURLでないか入力されたURLが間違っている可能性があります"
      # httpsを含まないURLは無効であること
      it "is valid with an url which does not contain https" do
        exercise.url = "http://www.youtube.com/watch?v=aaaaaaaaaaa"
        exercise.valid?
        expect(exercise.errors[:url]).to include(valid_url)
      end

      # youtubeを含まないURLは無効であること
      it "is valid with an url which does not contain youtube" do
        exercise.url = "https://www.nicovideo.com/watch?v=aaaaaaaaaaa"
        exercise.valid?
        expect(exercise.errors[:url]).to include(valid_url)
      end

      # youtu.beを含まないURLは無効であること
      it "is valid with an url which does not contain youtu.be" do
        exercise.url = "https://nico.video/aaaaaaaaaaa"
        exercise.valid?
        expect(exercise.errors[:url]).to include(valid_url)
      end

      # URLの最後が11文字の文字列を含まないURLは無効であること
      it "is valid with an url which does not contain 10 characters" do
        exercise.url = "https://www.youtube.com/watch?v=aaaaaaaaaa"
        exercise.valid?
        expect(exercise.errors[:url]).to include(valid_url)
      end
    end
  end
end
