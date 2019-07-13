class Note < ApplicationRecord
  acts_as_taggable

  validates :title, :body, presence: true
end
