require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:like) { create(:like)}

   # user_id,diary_idがあり有効なファクトリを持つこと
   it "has a valid factory" do
    expect(build(:like)).to be_valid
  end

  # 存在性チェック
  describe "test of presence" do
    # user_idがなければ無効な状態であること
    it "is invalid without a day" do
      like.user_id = nil
      like.valid?
      expect(like.errors.full_messages).to include("Userを入力してください")
    end

    # diary_idがなければ無効な状態であること
    it "is invalid without an image" do
      like.diary_id = nil
      like.valid?
      expect(like.errors.full_messages).to include("Diaryを入力してください")
    end
  end

    # 重複したuser_id,diary_idなら無効な状態であること
    it "is invalid with a duplicate like" do
      like.save
      dupulicate_like = build(:like, user_id: like.user_id, diary_id: like.diary_id)
      dupulicate_like.valid?
      expect(dupulicate_like.errors.full_messages).to include("Diaryはすでに存在します")
    end
end
