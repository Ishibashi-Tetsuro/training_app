require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }
  let(:diary) { create(:diary)}

   # 名前、メール、パスワードがあり、有効なファクトリを持つこと
   it "has a valid factory" do
    expect(build(:user)).to be_valid
  end

  # 存在性チェック
  describe "test of presence" do
    # 名前がなければ無効な状態であること
    it "is invalid without a name" do
      user.name = nil
      user.valid?
      expect(user.errors[:name]).to include("を入力してください")
    end

    # メールアドレスがなければ無効な状態であること
    it "is invalid without an email address" do
      user.email = nil
      user.valid?
      expect(user.errors[:email]).to include("を入力してください")
    end

    # パスワードがなければ無効な状態であること
    it "is invalid without a password" do
      user.password = nil
      user.valid?
      expect(user.errors[:password]).to include("を入力してください")
    end
  end

  # 重複したメールアドレスなら無効な状態であること
  it "is invalid with a duplicate email address" do
    user.save
    dupulicate_user = build(:user, email: user.email)
    dupulicate_user.valid?
    expect(dupulicate_user.errors[:email]).to include("はすでに存在します")
  end

  # メールアドレスは保存前に小文字変換されること
  it "convert  capital letters into email into small" do
    user.email = "TEST@GMAIL.COM"
    user.save
    expect(user.email).to eq "test@gmail.com"
  end

  # パスワードの正規表現
  describe "regex of password" do
    # 6文字以上12文字以下で、大文字・小文字・数字を最低1文字含むパスワードは有効であること
    it "is valid with a password which contains captal and small letters and number" do
      user.password = "Password12"
      expect(user).to be_valid
    end

    # 大文字を含まないパスワードは無効であること
    it "is valid with a password which does not contain capital letter" do
      user.password = "password12"
      user.valid?
      expect(user.errors[:password]).to include("は半角6~12文字英大文字・小文字・数字それぞれ１文字以上含む必要があります")
    end

    # 小文字を含まないパスワードは無効であること
    it "is valid with a password which does not contain small letter" do
      user.password = "PASSWORD12"
      user.valid?
      expect(user.errors[:password]).to include("は半角6~12文字英大文字・小文字・数字それぞれ１文字以上含む必要があります")
    end

    # 数字を含まないパスワードは無効であること
    it "is valid with a password which does not contain number" do
      user.password = "PASSWORDfail"
      user.valid?
      expect(user.errors[:password]).to include("は半角6~12文字英大文字・小文字・数字それぞれ１文字以上含む必要があります")
    end
  end

  # 名前の長さ
  describe "length of name" do
    # 16文字の名前は無効であること
    it "is invalid with a name which has over 16 characters" do
      user.name = "あ" * 16
      user.valid?
      expect(user.errors[:name]).to include("は15文字以内で入力してください")
    end

    # 15文字の名前は有効であること
    it "is valid with a name which has 300 characters" do
      user.name = "あ" * 15
      expect(user).to be_valid
    end
  end

  # 画像のアップロード
  describe "check image upload" do
    # 画像なしでも有効であること
    it "is valid with no image" do
      user = build(:user, image: nil)
      expect(user).to be_valid
    end

    # 5MBを超える画像はアップロードできないこと
    it "can not upload an image over 5MB" do
      image_path = Rails.root.join("public/default/over5mb.jpg")
      user = build(:user, image: File.open(image_path))
      user.valid?
      expect(user.errors[:image]).to include "は5MB以下にする必要があります"
    end
  end

  # 削除の依存関係
  describe "dependent: destoy" do
    # 削除すると、紐づく日記も全て削除されること
    it "destroys all diaries when deleted" do
      create(:diary, user: user)
      expect { user.destroy }.to change(Diary, :count).by(-1)
    end

    # 削除すると、紐づくスケジュールも全て削除されること
    it "destroys all scheudles when deleted" do
      create(:schedule, user: user)
      expect { user.destroy }.to change(Schedule, :count).by(-1)
    end

    # 削除すると、紐づくエクササイズも全て削除されること
    it "destroys all exercises when deleted" do
      create(:exercise, user: user)
      expect { user.destroy }.to change(Exercise, :count).by(-1)
    end

    # 削除すると、紐づくいいね！(likes)も全て削除されること
    it "destroys all likes when deleted" do
      create(:like, user: user, diary: diary)
      expect { user.destroy }.to change(Like, :count).by(-1)
    end

    # 削除すると、紐づくカウントも全て削除されること
    it "destroys all count when deleted" do
      create(:count, user: user)
      expect { user.destroy }.to change(Count, :count).by(-1)
    end
  end
end
