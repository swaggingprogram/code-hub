class CodesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :template, only: [:show, :new]
  
  def index
    @codes = Code.all.order("created_at DESC")
  end

  def new
    @code = Code.new
  end

  def create
    @code = Code.new(code_params)
    if @code.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    @code = Code.find(params[:id])
  end

  def update
    @code = Code.find(params[:id])
    if @code.update(code_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    code = Code.find(params[:id])
    if code.user.id == current_user.id
      code.destroy
      redirect_to root_path
    end
  end

  def show
    @code = Code.find(params[:id])
    @comment = Comment.new
    @comments = @code.comments.includes(:user)
  end

  private
  def code_params
    params.require(:code).permit(:title, :codetext, :category_id, :genre_id).merge(user_id: current_user.id)
  end

  def template
    @template = " ```マークダウンで記入できます
    
 ```"
  end
end
