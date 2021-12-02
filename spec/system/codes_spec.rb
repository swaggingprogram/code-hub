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

RSpec.describe 'ツイート編集', type: :system do
  before do
    @code1 = FactoryBot.create(:code)
    @code2 = FactoryBot.create(:code)
  end
  context 'ツイート編集ができるとき' do
    it 'ログインしたユーザーは自分が投稿したツイートの編集ができる' do
      # ツイート1を投稿したユーザーでログインする
      basic_pass root_path
      visit new_user_session_path
      fill_in "email", with: @code1.user.email
      fill_in "password", with: @code1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # ツイート1の詳細に遷移する
      visit code_path(@code1)
      # ツイート1に「編集」へのリンクがあることを確認する
      expect(page).to have_link '編集', href: edit_code_path(@code1)
      # 編集ページへ遷移する
      visit edit_code_path(@code1)
      # すでに投稿済みの内容がフォームに入っていることを確認する
      expect(
        find_by_id('code').value
      ).to eq(@code1.codetext)
      expect(
        find_by_id('code_title').value
      ).to eq(@code1.title)
      expect(
        find_by_id('code_category_id').value
      ).to eq("#{@code1.category_id}")
      expect(
        find_by_id('code_genre_id').value
      ).to eq("#{@code1.genre_id}")
      # 投稿内容を編集する
      fill_in "code", with: "#{@code1.codetext}"
      fill_in "code_title", with: "#{@code1.title}"
      select Category.data[@code1.category_id - 1][:name], from: "code[category_id]"
      select Genre.data[@code1.genre_id - 1][:name], from: "code[genre_id]"
      # 編集してもTweetモデルのカウントは変わらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Code.count }.by(0)
      # トップページに遷移する
      expect(current_path).to eq(root_path)
      # トップページには先ほど変更した内容のツイートが存在することを確認する（タイトル）
      expect(page).to have_content(@code_title)
      # トップページには先ほど変更した内容のツイートが存在することを確認する（テキスト）
      expect(page).to have_content(@code_text)
    end
  end
  context 'ツイート編集ができないとき' do
    it 'ログインしたユーザーは自分以外が投稿したツイートの編集画面には遷移できない' do
      # ツイート1を投稿したユーザーでログインする
      basic_pass root_path
      visit new_user_session_path
      fill_in "email", with: @code1.user.email
      fill_in "password", with: @code1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # ツイート2の詳細に遷移する
      visit code_path(@code1)
      # ツイート2に「編集」へのリンクがないことを確認する
      expect(page).to have_no_link '編集', href: edit_code_path(@code2)
    end
    it 'ログインしていないとツイートの編集画面には遷移できない' do
      # トップページにいる
      basic_pass root_path
      # ツイート1に「編集」へのリンクがないことを確認する
      visit code_path(@code1)
      expect(page).to have_no_link '編集', href: edit_code_path(@code1)
      # ツイート2に「編集」へのリンクがないことを確認する
      visit code_path(@code2)
      expect(page).to have_no_link '編集', href: edit_code_path(@code2)
    end
  end
end

RSpec.describe 'ツイート削除', type: :system do
  before do
    @code1 = FactoryBot.create(:code)
    @code2 = FactoryBot.create(:code)
  end
  context 'ツイート削除ができるとき' do
    it 'ログインしたユーザーは自らが投稿したツイートの削除ができる' do
      # ツイート1を投稿したユーザーでログインする
      basic_pass root_path
      visit new_user_session_path
      fill_in "email", with: @code1.user.email
      fill_in "password", with: @code1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # ツイート1の詳細に遷移する
      visit code_path(@code1)
      # ツイート1に「削除」へのリンクがあることを確認する
      expect(page).to have_link '削除', href: code_path(@code1)
      # 投稿を削除するとレコードの数が1減ることを確認する
      expect{
        find_link("削除", href: code_path(@code1)).click
      }.to change { Code.count }.by(-1)
      # トップページに遷移する
      expect(current_path).to eq(root_path)
      # トップページにはツイート1の内容が存在しないことを確認する（画像）
      expect(page).to have_no_content("#{@code1.title}")
      # トップページにはツイート1の内容が存在しないことを確認する（テキスト）
      expect(page).to have_no_content("#{@code1.codetext}")
    end
  end
  context 'ツイート削除ができないとき' do
    it 'ログインしたユーザーは自分以外が投稿したツイートの削除ができない' do
      # ツイート1を投稿したユーザーでログインする
      basic_pass root_path
      visit new_user_session_path
      fill_in "email", with: @code1.user.email
      fill_in "password", with: @code1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # ツイート2の詳細に遷移する
      visit code_path(@code2)
      # ツイート2に「削除」へのリンクがないことを確認する
      expect(page).to have_no_link '削除', href: code_path(@code2)
    end
    it 'ログインしていないとツイートの削除ボタンがない' do
      # トップページに移動する
      basic_pass root_path
      # ツイート1に「削除」へのリンクがないことを確認する
      expect(page).to have_no_link '削除', href: code_path(@code1)
      # ツイート2に「削除」へのリンクがないことを確認する
      expect(page).to have_no_link '削除', href: code_path(@code2)
    end
  end
end

RSpec.describe 'ツイート詳細', type: :system do
  before do
    @code = FactoryBot.create(:code)
  end
  it 'ログインしたユーザーはツイート詳細ページに遷移してコメント投稿欄が表示される' do
    # ログインする
    basic_pass root_path
    visit new_user_session_path
    fill_in "email", with: @code.user.email
    fill_in "password", with: @code.user.password
    find('input[name="commit"]').click
    expect(current_path).to eq(root_path)
    # ツイートに「詳細」へのリンクがあることを確認する
    expect(
      all(".code-image")[0]).to have_link(nil, href: code_path(@code))
    # 詳細ページに遷移する
    visit code_path(@code)
    # 詳細ページにツイートの内容が含まれている
    expect(page).to have_content("#{@code.codetext}")
    expect(page).to have_content("#{@code.title}")
    # コメント用のフォームが存在する
    expect(page).to have_selector('.comment-content')
  end
  it 'ログインしていない状態でツイート詳細ページに遷移できるもののコメント投稿欄が表示されない' do
    # トップページに移動する
    basic_pass root_path
    # ツイートに「詳細」へのリンクがあることを確認する
    expect(
      all(".code-image")[0]).to have_link(nil, href: code_path(@code))
    # 詳細ページに遷移する
    visit code_path(@code)
    # 詳細ページにツイートの内容が含まれている
    expect(page).to have_content("#{@code.codetext}")
    expect(page).to have_content("#{@code.title}")
    # フォームが存在しないことを確認する
    expect(page).to have_no_selector('.comment-content')
  end
end
