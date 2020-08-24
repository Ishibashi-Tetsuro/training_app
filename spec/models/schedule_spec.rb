require 'rails_helper'

RSpec.describe Schedule, type: :model do
  let(:schedule) { create(:schedule)}

   # part,trainig_date,shape,work,user_idがあり有効なファクトリを持つこと
   it "has a valid factory" do
    expect(build(:exercise)).to be_valid
  end

  # 存在性チェック
  describe "test of presence" do
    #  partがなければ無効な状態であること
    it "is invalid without a part" do
      schedule.part = nil
      schedule.valid?
      expect(schedule.errors[:part]).to include("を入力してください")
    end

    #  training_dataがなければ無効な状態であること
    it "is invalid without a training_date" do
      schedule.training_date = nil
      schedule.valid?
      expect(schedule.errors[:training_date]).to include("を入力してください")
    end

    #  shapeがなければ無効な状態であること
    it "is invalid without a shape" do
      schedule.shape = nil
      schedule.valid?
      expect(schedule.errors[:shape]).to include("を入力してください")
    end

    #  workがなければ無効な状態であること
    it "is invalid without a work" do
      schedule.work = nil
      schedule.valid?
      expect(schedule.errors[:work]).to include("を入力してください")
    end

    #  user_idがなければ無効な状態であること
    it "is invalid without a user_id" do
      schedule.user_id = nil
      schedule.valid?
      expect(schedule.errors.full_messages).to include("Userを入力してください")
    end
  end

  # 部位
  describe "part" do
    # 有効パターン
    context "valid entry" do
      ['二の腕', 'お腹', '胸', '足'].each do |valid_part|
        # 二の腕、お腹、胸、足は有効であること
        it "is valid with #{valid_part}" do
          expect(build(:schedule, part: valid_part)).to be_valid
        end
      end
    end
    # 無効パターン
    context "invalid entry" do
      # 二の腕、お腹、胸、以外は無効であること
      it "is invalid without 二の腕, お腹, 胸, 足" do
        schedule.part = "a"
        schedule.valid?
        expect(schedule.errors[:part]).to include("は一覧にありません")
      end
    end
  end

  # work
  describe "work" do
    # 有効パターン
    context "valid entry" do
      ['早番', '遅番', '休み'].each do |valid_work|
        # 早番、遅番、休みは有効であること
        it "is valid with #{valid_work}" do
          expect(build(:schedule, work: valid_work)).to be_valid
        end
      end
    end
    # 無効パターン
    context "invalid entry" do
      # 早番、遅番、休み以外は無効であること
      it "is invalid without 早番、遅番、休み" do
        schedule.work = "a"
        schedule.valid?
        expect(schedule.errors[:work]).to include("は一覧にありません")
      end
    end
  end

  # shape
  describe "shape" do
    # 有効パターン
    context "valid entry" do
      ['良い', '不調'].each do |valid_shape|
        # 良い、不調は有効であること
        it "is valid with #{valid_shape}" do
          expect(build(:schedule, shape: valid_shape)).to be_valid
        end
      end
    end
    # 無効パターン
    context "invalid entry" do
      # 良い、不調以外は無効であること
      it "is invalid without 良い、不調" do
        schedule.shape = "a"
        schedule.valid?
        expect(schedule.errors[:shape]).to include("は一覧にありません")
      end
    end
  end
end
