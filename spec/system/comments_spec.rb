require 'rails_helper'

def basic_pass(path)
  username = ENV["BASIC_AUTH_USER"] 
  password = ENV["BASIC_AUTH_PASSWORD"]
  visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}#{path}"
end

RSpec.describe "Comments", type: :system do
  before do
    @code = FactoryBot.create(:code)
    @comment = Faker::Lorem.sentence
  end
  it 'ログインしたユーザーはツイート詳細ページでコメント投稿できる' do
    # ログインする
    basic_pass root_path
    visit new_user_session_path
    fill_in "email", with: @code.user.email
    fill_in "password", with: @code.user.password
    find('input[name="commit"]').click
    expect(current_path).to eq(root_path)
    # ツイート詳細ページに遷移する
    visit code_path(@code)
    # フォームに情報を入力する
    fill_in "comment_concept", with: @comment
    # コメントを送信すると、Commentモデルのカウントが1上がることを確認する
    expect{
      find('input[name="commit"]').click
    }.to change { Comment.count }.by(1)
    # 詳細ページにリダイレクトされることを確認する
    expect(current_path).to eq(code_path(@code))
    # 詳細ページ上に先ほどのコメント内容が含まれていることを確認する
    expect(page).to have_content(@comment)
  end
end
