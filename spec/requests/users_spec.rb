require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:user) { create(:user) }
  let(:valid_attributes) { { name: Faker::Name.name, email: Faker::Internet.email, password: 'ttttttT1', password_confirmation: 'ttttttT1' } }
  let(:invalid_attributes) { { name: '', email: 'Faker::Internet.email' } }

  # 名前、メール、パスワードがあり、有効なファクトリを持つこと
  it "has a valid factory" do
    expect(build(:user)).to be_valid
  end

  # ログインページへリクエスト
  describe 'GET sessions#new' do
    # 正常にアクセスが返ってくる
    it 'renders a successful response' do
      get new_user_session_path
      expect(response).to be_successful
    end
  end

  # テストユーザーのログイン
  describe 'POST sessions#new_guest' do
    # 成功するとルートパスへリダイレクトされる
    it 'redirects to the root_path' do
      post users_guest_sign_in_path
      expect(response).to redirect_to root_path
    end
  end

  # ログイン処理
  describe 'POST sessions#create' do
    # 正しくログインできた場合
    context 'with valid parameters' do
      # ルートパスへリダイレクトされる
      it 'redirects to the root_path' do
        sign_in user
        post user_session_path, params: { user: user }
        expect(response).to redirect_to root_path
      end
    end
    # ログインに失敗した場合
    context 'with invalid parameters' do
       # ログインページが再表示される
       it 'renders a successful response(:new)' do
        post user_session_path, params: { user: invalid_attributes }
        expect(response.body).to include 'メールアドレスまたはパスワードが違います'
      end
    end
  end

  # ログアウト処理
  describe 'DELETE sessions#destroy' do
    # 正しくログアウトできた場合ルートパスへリダイレクトされる
    it 'redirects to the root_path' do
      delete destroy_user_session_path
      expect(response).to redirect_to root_path
    end
  end

  # 新規登録ページへアクセス
  describe 'GET registrations#new' do
    # 正常にリクエストが返ってくる
    it 'renders a successful response' do
      get new_user_registration_path
      expect(response).to be_successful
    end
  end

  # ユーザー情報編集ページへアクセス
  describe 'GET registrations#edit' do
    # 正常にリクエストが返ってくる
    it 'renders a successful response' do
      sign_in user
      get edit_user_registration_path(user)
      expect(response).to be_successful
    end
  end

=begin
  # ユーザー情報を更新
  describe 'PATCH registrations#update' do
    # 正しく更新できた場合
    context 'with valid parameters' do
      # ユーザー情報が更新されている
      it 'updates the requested user' do
        sign_in user
        patch user_registration_path, params: { user: user_params }
        user.reload
        expect('tanaka').to eq user.name
      end
      # ユーザー詳細ページへリダイレクト
      it 'redirects to the user' do
        sign_in user
        patch user_registration_path, params: { user: user_params }
        expect(response).to redirect_to user_path(user)
      end
    end
    # 更新に失敗した場合
    context 'with invalid parameters' do
      it "renders a successful response(:new)" do
        sign_in user
        patch user_registration_path, params: { user: user_params }
        expect(response.body).to include 'Edit User'
      end
    end
  end
=end

  # ユーザー情報の削除
  describe 'DELETE registration#destroy' do
    # 削除に成功するとレコードが１つ減る
    it 'destroys the requested user' do
      sign_in user
      expect do
        delete user_registration_path
      end.to change(User, :count).by(-1)
    end
    # 削除に成功するとルートパスにリダイレクトされる
    it 'redirects to the users list' do
      sign_in user
      delete user_registration_path
      expect(response).to redirect_to root_path
    end
  end

  # ユーザーの新規登録
  describe 'POST registration#create' do
    # 成功パターン
    context 'with valid parameters' do
      # レコードが１つ増加する
      it 'creates a new User' do
        expect do
          post user_registration_path, params: { user: valid_attributes }
        end.to change(User, :count).by(1)
      end
      # ルーとパスへリダイレクトされる
      it 'redirects to the root path' do
        post user_registration_path, params: { user: valid_attributes }
        expect(response).to redirect_to root_path
      end
    end
    # 失敗パターン
    context 'with invalid parameters' do
      # レコードは増加しない
      it 'does not create a new User' do
        expect do
          post user_registration_path, params: { user: invalid_attributes }
        end.to change(User, :count).by(0)
      end
      # 新規登録画面が再表示される
      it "renders a successful response(:new)" do
        post user_registration_path, params: { user: invalid_attributes }
        expect(response.body).to include '保存されませんでした'
      end
    end
  end

  # ユーザー詳細ページへリクエスト
  describe 'GET #show' do
    # 正常にリクエストが返ってくる
    it 'renders a successful response' do
      get user_path(user)
      expect(response).to be_successful
    end
  end
end
