class CodesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :template, only: [:show, :new]
  before_action :code_guard, only: [:edit]

  def index
    @codes = Code.all.order("created_at DESC")
    @histories = History.all
    @randoms = Code.order("RAND()").limit(1)
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

    if user_signed_in?
      new_history = @code.histories.new
      new_history.user_id = current_user.id
  
      if current_user.histories.exists?(code_id: "#{params[:id]}")
        old_history = current_user.histories.find_by(code_id: "#{params[:id]}")
        old_history.destroy
      end
  
      new_history.save
  
      histories_stock_limit = 10
      histories = current_user.histories.all 
      if histories.count > histories_stock_limit
        histories[0].destroy
      end
    end

  end

  private
  def code_params
    params.require(:code).permit(:title, :codetext, :category_id, :genre_id).merge(user_id: current_user.id)
  end

  def template
    @template = " ```マークダウンで記入できます\n    \n ```"
  end

  def code_guard
    unless @item.user.id == current_user.id
      redirect_to action: :index 
    end
  end
end


