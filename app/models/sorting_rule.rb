class SortingRule < ActiveRecord::Base
  belongs_to :category

  validates :contains, :presence => true

  validates :category, :presence => true

  delegate :name, :to => :category, :prefix => true

  def tags
    Tag.where(id: tag_ids)
  end

  def tags=(tag_list)
    if tag_list.is_a? Array
      self.tag_ids = tag_list.map(&:id)
    elsif tag_list.is_a? String
      self.tag_ids = Tag.tags_from_string(tag_list).map(&:id)
    else
      raise StandardError.new 'unknown tag list'
    end
  end
end
