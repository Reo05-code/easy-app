class TopicsController < ApplicationController
  before_action :set_topic, only: [:edit, :update]

  def new
    @topic = Topic.new
  end

  def create
    @topic = Topic.new(topic_params)

    if @topic.save
      # タグ入力があればsplitして登録
      if tag_params[:name].present?
        input_tags = tag_params[:name].split(' ')
        @topic.create_tags(input_tags)
      end
      redirect_to topics_path, notice: 'トピックを作成しました。'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @topic.update(topic_params)
      if tag_params[:name].present?
        input_tags = tag_params[:name].split(' ')
        @topic.update_tags(input_tags)
      else
        # タグが空になった場合は全削除
        @topic.tags.clear
      end
      redirect_to edit_topic_path(@topic), notice: 'トピックを更新しました。'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_topic
    @topic = Topic.find(params[:id])
  end

  def topic_params
    params.require(:topic).permit(:title)
  end

  def tag_params
    params.require(:topic).permit(:name)
  end
end

