class PostsController < ApplicationController
  before_action :authenticate_user!  # ← これでログイン必須にする
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @posts = Post.where(user_id: current_user.id)
  end

  def show
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to @post, notice: "投稿しました！"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: "更新しました！"
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: "削除しました！"
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def correct_user
    redirect_to posts_path, alert: "権限がありません" unless @post.user == current_user
  end
end
