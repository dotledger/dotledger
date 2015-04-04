class Tag < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true

  def self.tags_from_string(tag_list)
    tag_list.split(/,\s*/).map do |tag_name|
      Tag.where(name: tag_name.strip).first_or_create
    end
  end
end
