class Argument < ApplicationRecord
  belongs_to :proposition
  belongs_to :author, class_name: 'User'

  validates :body, presence: true
  validates :side, inclusion: { in: [true, false] }
end
