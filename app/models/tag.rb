class Tag < ActiveRecord::Base
  has_many :identifiers
  has_and_belongs_to_many :performers
end
