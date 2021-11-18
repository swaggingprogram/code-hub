class CodesController < ApplicationController
  def index
    @codes = Code.all.order("created_at DESC")
  end

  def new
    @code = Code.new
  end

  def create
    @code = Item.new(code_params)
    if @code.save
      redirect_to root_path
    else
      render :new
    end
  end

  private
  def code_params
    params.require(:code).permit(:title, :codetext, :category_id, :genre_id).merge(user_id: current_user.id)
  end
end
