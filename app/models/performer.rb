class Performer < ActiveRecord::Base
  has_and_belongs_to_many :tags


  def collate_tags_with_db(sc_tags)
    db_identifiers = []
    Identifier.all.each do |object|
      db_identifiers << object.value
    end
    matching = db_identifiers & sc_tags
    p "matching: #{matching}"
    if matching.length > 0
      matching.each do |value|
        self.tags << Tag.find_by(value: value)
      end
    end

  end
end
