require 'rails_helper'

RSpec.describe Code, type: :model do
  before do
    @code = FactoryBot.build(:code)
  end

  describe 'コード新規投稿' do
    context '新規投稿できる場合' do
      it 'タイトル、コード内容、カテゴリー、ジャンルを入力すれば登録できる' do
        expect(@code).to be_valid
      end
    end
    context '新規投稿できない場合' do
      it 'titleが空では登録できない' do
        @code.title = ''
        @code.valid?
        expect(@code.errors.full_messages).to include("Title can't be blank")
      end
      it 'codetextが空では登録できない' do
        @code.codetext = ''
        @code.valid?
        expect(@code.errors.full_messages).to include("Codetext can't be blank")
      end
      it 'categoryが空では登録できない' do
        @code.category_id = ''
        @code.valid?
        expect(@code.errors.full_messages).to include("Category can't be blank")
      end
      it 'categoryが1では登録できない' do
        @code.category_id = '1'
        @code.valid?
        expect(@code.errors.full_messages).to include("Category can't be blank")
      end
      it 'genreが空では登録できない' do
        @code.genre_id = ''
        @code.valid?
        expect(@code.errors.full_messages).to include("Genre can't be blank")
      end
      it 'genreが1では登録できない' do
        @code.genre_id = '1'
        @code.valid?
        expect(@code.errors.full_messages).to include("Genre can't be blank")
      end
      it 'ユーザーに紐づいてないと出品できない' do
        @code.user = nil
        @code.valid?
        expect(@code.errors.full_messages).to include('User must exist')
      end
    end
  end
end
