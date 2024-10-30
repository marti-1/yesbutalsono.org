class Proposition < ApplicationRecord
  extend FriendlyId
  friendly_id :body, use: :slugged

  belongs_to :author, class_name: 'User'
  has_many :votes, as: :votable
  has_many :arguments, dependent: :destroy

  # validate presence of body
  validates :body, presence: true

  after_create :give_author_upvote

  def yes_arguments
    arguments.where(side: true).order(created_at: :asc)
  end

  def no_arguments
    arguments.where(side: false).order(created_at: :asc)
  end

  def upvote_by(user)
    vote(user, 1)
  end

  def downvote_by(user)
    vote(user, -1)
  end

  def vote(user, value)
    ActiveRecord::Base.transaction do
      votes.find_or_initialize_by(user: user).tap do |vote|
        # if vote with this value was already cast, do nothing
        next if vote.persisted? && vote.value == value
        # if user has not already cast the vote, cast it
        if !vote.persisted?
          vote.value = value
          vote.save
          # run raw sql update query in order to update Proposition's cached_votes_total
          change = value == 1 ? "+ 1" : "- 1"
          update_cached_votes_total(change)
        # if vote was cast but with different value, update it
        else
          vote.update(value: value)
          change = value == 1 ? "+ 2" : "- 2"
          update_cached_votes_total(change)
        end
      end
    end
  end

  def update_cached_votes_total(change)
    sql = <<-SQL
      UPDATE propositions
      SET cached_votes_total = cached_votes_total #{change}
      WHERE id = ?
    SQL
    ActiveRecord::Base.connection.execute(
      ActiveRecord::Base.send(:sanitize_sql_array, [sql, id])
    )
    reload
  end

  private

  def give_author_upvote
    upvote_by(author)
  end

end
