require 'rails_helper'

RSpec.describe Diary, type: :model do
  let(:user) { create(:user) }
  let(:diary) { create(:diary)}

   # 本文、画像があり有効なファクトリを持つこと
   it "has a valid factory" do
    expect(build(:diary)).to be_valid
  end

  # 存在性チェック
  describe "test of presence" do
    #  本文がなければ無効な状態であること
    it "is invalid without a content" do
      diary.content = nil
      diary.valid?
      expect(diary.errors[:content]).to include("を入力してください")
    end

    # 写真がなければ無効な状態であること
    it "is invalid without an image" do
      diary.image = nil
      diary.valid?
      expect(diary.errors[:image]).to include("が添付されていません")
    end

    # user_idがなければ無効な状態であること
    it "is invalid without an image" do
      diary.user_id = nil
      diary.valid?
      expect(diary.errors.full_messages).to include("Userを入力してください")
    end
  end

  # 本文の長さ
  describe "length of content" do
    # 201文字の本文は無効であること
    it "is invalid with a content which has over 201 characters" do
      diary.content = "あ" * 201
      diary.valid?
      expect(diary.errors[:content]).to include("は200文字以内で入力してください")
    end

    # 200文字の名前は有効であること
    it "is valid with a name which has 200 characters" do
      diary.content = "あ" * 200
      expect(diary).to be_valid
    end
  end

  # 画像のアップロード
  describe "check image upload" do
    # 5MBを超える画像はアップロードできないこと
    it "can not upload an image over 5MB" do
      image_path = Rails.root.join("public/default/over5mb.jpg")
      diary = build(:diary, image: File.open(image_path))
      diary.valid?
      expect(diary.errors[:image]).to include "は5MB以下にする必要があります"
    end
  end

  # 削除の依存関係
  describe "dependent: destoy" do
    # 削除すると、紐づくいいいね！も全て削除されること
    it "destroys all likes when deleted" do
      create(:like, user: user, diary: diary)
      expect { diary.destroy }.to change(Like, :count).by(-1)
    end
  end
end
