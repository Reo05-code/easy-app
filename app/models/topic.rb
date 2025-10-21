class Topic < ApplicationRecord
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  # ==============================
  # 新規作成時
  # ==============================
  def create_tags(input_tags)
    input_tags.each do |tag|
      next if tag.blank? # 空文字をスキップ
      new_tag = Tag.find_or_create_by(name: tag.strip)
      tags << new_tag unless tags.include?(new_tag)
    end
  end

  # ==============================
  # 更新時
  # ==============================
  def update_tags(input_tags)
    # 現在のタグを配列化
    registered_tags = tags.pluck(:name)

    # 差分を計算
    new_tags = input_tags - registered_tags        # 新しく追加されたタグ
    remove_tags = registered_tags - input_tags     # 削除されたタグ

    # 新しいタグを追加
    new_tags.each do |tag|
      next if tag.blank?
      new_tag = Tag.find_or_create_by(name: tag.strip)
      tags << new_tag unless tags.include?(new_tag)
    end

    # 削除されたタグを中間テーブルから削除
    remove_tags.each do |tag|
      old_tag = Tag.find_by(name: tag)
      taggings.find_by(tag_id: old_tag.id)&.destroy if old_tag
    end
  end
end
