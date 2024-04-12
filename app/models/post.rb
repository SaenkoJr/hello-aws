# frozen_string_literal: true

class Post < ApplicationRecord
  has_rich_text :body

  validates :title, presence: true, length: { maximum: 50 }
end
