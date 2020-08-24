require 'rails_helper'

RSpec.describe Count, type: :model do
  let(:count) { create(:count)}

   # 日数があり有効なファクトリを持つこと
   it "has a valid factory" do
    expect(build(:count)).to be_valid
  end

  # 存在性チェック
  describe "test of presence" do
    # 日数がなければ無効な状態であること
    it "is invalid without a day" do
      count.day = nil
      count.valid?
      expect(count.errors[:day]).to include("を入力してください")
    end

    # user_idがなければ無効な状態であること
    it "is invalid without an image" do
      count.user_id = nil
      count.valid?
      expect(count.errors.full_messages).to include("Userを入力してください")
    end
  end
end
