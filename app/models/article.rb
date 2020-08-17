class Article < ApplicationRecord
  has_many :comments, dependent: :delete_all
  has_many :taggings, dependent: :delete_all
  has_many :tags, through: :taggings, dependent: :delete_all
  has_attached_file :image
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png"]

  def tag_list
    tags.collect do |tag|
      tag.name
    end.join(', ')
  end

  def tag_list=(tags_string)
    tags_name = tags_string.split(',').collect { |s| s.strip.downcase }.uniq
    new_or_found_tag = tags_name.collect { |name| Tag.find_or_create_by(name: name) }
    self.tags = new_or_found_tag
  end
end
