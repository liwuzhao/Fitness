class Article < ApplicationRecord
  mount_uploader :image, ImageUploader #文章封面图

  belongs_to :user

  has_many :article_reviews

  # 文章点赞
  has_many :article_collections 
  has_many :members, through: :article_collections, source: :user

  # 发表/文章

  def publish!
    self.is_hidden = false
    self.save
  end

  def hide!
    self.is_hidden = true
    self.save
  end
end
