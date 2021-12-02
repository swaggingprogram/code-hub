require 'rails_helper'

def basic_pass(path)
  username = ENV["BASIC_AUTH_USER"] 
  password = ENV["BASIC_AUTH_PASSWORD"]
  visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}#{path}"
end

RSpec.describe "Codes", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @code_title = Faker::Name.initials(number: 6)
    @code_text = Faker::Lorem.sentence
    @code_category = "Ruby"
    @code_genre = "初心者向け"
  end
  context 'コードの投稿ができるとき'do
    it 'ログインしたユーザーは新規投稿できる' do
      #basic認証を突破する
      basic_pass root_path
      # ログインする
      visit new_user_session_path
      fill_in 'email', with: @user.email
      fill_in 'password', with: @user.password
      find('input[name="commit"]').click
      # 新規投稿ページへのボタンがあることを確認する
      expect(page).to have_content('NEW POST')
      # 投稿ページに移動する
      visit new_code_path
      # フォームに情報を入力する
      fill_in 'new-code', with: @code_text
      fill_in 'code_title', with: @code_title
      select @code_category, from: "code[category_id]"
      select @code_genre, from: "code[genre_id]"
      # 送信するとTweetモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Code.count }.by(1)
      # 投稿完了ページに遷移することを確認する
      expect(current_path).to eq(root_path)
      # トップページには先ほど投稿した内容のツイートが存在することを確認する（タイトル)
      expect(page).to have_content(@code_title)
      # トップページには先ほど投稿した内容のツイートが存在することを確認する（テキスト）
      expect(page).to have_content(@code_text)
    end
  end
  context 'ツイート投稿ができないとき'do
    it 'ログインしていないと新規投稿ページに遷移できない' do
      # トップページに遷移する
      basic_pass root_path
      # 新規投稿ページへのボタンがないことを確認する
      expect(page).to have_content('NEW POST')
    end
  end
end

