class Proposition < ApplicationRecord
  extend FriendlyId
  friendly_id :body, use: :slugged

  belongs_to :author, class_name: 'User'

  # validate presence of body
  validates :body, presence: true
end
