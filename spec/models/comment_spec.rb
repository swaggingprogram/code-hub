require 'rails_helper'

RSpec.describe Comment, type: :model do
  before do
    @comment = FactoryBot.build(:comment)
  end

  describe 'コメント新規投稿' do
    context '新規投稿できる場合' do
      it 'コメントを入力すれば登録できる' do
        expect(@comment).to be_valid
      end
    end
    context '新規投稿できない場合' do
      it 'conceptが空では登録できない' do
        @comment.concept = ''
        @comment.valid?
        expect(@comment.errors.full_messages).to include("Concept can't be blank")
      end
      it 'ユーザーに紐づいてないと出品できない' do
        @comment.user = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include('User must exist')
      end
      it 'コードに紐づいてないと出品できない' do
        @comment.code = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include('Code must exist')
      end
    end
  end
end
