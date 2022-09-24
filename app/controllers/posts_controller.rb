class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:success] = "スケジュールを登録しました"
      redirect_to posts_url
    else
      flash.now[:error] = "スケジュールを登録できませんでした"
      render 'new'
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:success] = "スケジュールを編集しました"
      redirect_to posts_url
    else
      flash.now[:error] = "スケジュールを編集できませんでした"
      render 'edit'
    end
  end

  def destroy
    Post.find(params[:id]).destroy
    flash[:success] = "スケジュールを削除しました"
    redirect_to posts_url
  end

  private
    def post_params
      params.require(:post).permit(:title, :start_day, :end_day, :all_day, :memo)
    end
end
