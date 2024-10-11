class AddCachedVoteCountToPropositions < ActiveRecord::Migration[7.2]
  def change
    add_column :propositions, :cached_votes_total, :integer, default: 0
  end
end
