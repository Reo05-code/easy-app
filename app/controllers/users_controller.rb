class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  # ユーザー一覧
  def index
    @users = User.all
  end

  # ユーザー詳細（投稿一覧も表示）
  def show
    @posts = @user.posts
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
