require 'rails_helper'

RSpec.describe "Daiaries", type: :request do
  image_path = Rails.root.join("app/assets/images/default.png")
  let(:user) { create(:user) }
  let(:diary) { create(:diary) }
  let(:valid_attributes) { { content: 'enjoy today', image: Rack::Test::UploadedFile.new(File.join(Rails.root, 'app/assets/images/default.png'), 'default.png') } }
  let(:invalid_attributes) { { content: '' } }

  # 投稿内容、画像、user_idがあり、有効なファクトリを持つこと
it "has a valid factory" do
  expect(build(:diary)).to be_valid
end

  # 投稿一覧ページへリクエスト
  describe 'GET #index' do
    # 正常にアクセスが返ってくる
    it 'renders a successful response' do
      get diaries_path
      expect(response).to be_successful
    end
  end

  # 新規投稿ページへアクセス
  describe 'GET #new' do
    # 正常にリクエストが返ってくる
    it 'renders a successful response' do
      sign_in user
      get new_diary_path
      expect(response).to be_successful
    end
  end

  # 投稿の新規作成
  describe 'POST #create' do
    # 成功パターン
    context 'with valid parameters' do
      # レコードが１つ増加する
      it 'creates a new Diary' do
        sign_in user
        expect do
          post diaries_path, params: { diary: valid_attributes }
        end.to change(Diary, :count).by(1)
      end
      # indexページへリダイレクトされる
      it 'redirects to the index page' do
        sign_in user
        post diaries_path, params: { diary: valid_attributes }
        expect(response).to redirect_to diaries_path
      end
    end
    # 失敗パターン
    context 'with invalid parameters' do
      # レコードは増加しない
      it 'does not create a new Diary' do
        sign_in user
        expect do
          post diaries_path, params: { diary: invalid_attributes }
        end.to change(Diary, :count).by(0)
      end
      # 新規投稿画面が再表示される
      it "renders a successful response(:new)" do
        sign_in user
        post diaries_path, params: { diary: invalid_attributes }
        expect(response.body).to include '新しい日記を投稿'
      end
    end
  end

  # 日記編集ページへアクセス
  # describe 'GET #edit' do
    # 正常にリクエストが返ってくる
  #   it 'renders a successful response' do
  #     sign_in user
  #     get edit_diary_path(diary)
  #     expect(response).to be_successful
  #   end
  # end

  # 日記を更新
  describe 'PATCH #update' do
    # 正しく更新できた場合
    context 'with valid parameters' do
      # ユーザー情報が更新されている
      it 'updates the requested user' do
        sign_in user
        put diary_path(diary), params: { diary: valid_attributes }
        diary.reload
        expect(diary.content).to eq 'enjoy today'
      end
      # ユーザー詳細ページへリダイレクト
      it 'redirects to the user' do
        sign_in user
        patch diary_path(diary), params: { diary: valid_attributes }
        expect(response).to redirect_to diary_path(diary)
      end
    end
    # 更新に失敗した場合
    context 'with invalid parameters' do
      # 日記編集ページが再表示される
      it "renders a successful response(:edit)" do
        patch diary_path(diary), params: { diary: invalid_attributes }
        expect(response.body).to include '日記編集'
      end
    end
  end

  #日記の削除
  describe 'DELETE #destroy' do
    # 削除に成功するとレコードが１つ減る
    it 'destroys the requested diary' do
      expect do
        delete diary_path(diary)
      end.to change(Diary, :count).by(-1)
    end
    # 削除に成功すると日記一覧ページへリダイレクトされる
    it 'redirects to the diary index' do
      sign_in user
      delete diary_path(diary)
      expect(response).to redirect_to diaries_path
    end
  end
end
