class AddSlugToPropositions < ActiveRecord::Migration[7.2]
  def change
    add_column :propositions, :slug, :string
    add_index :propositions, :slug, unique: true
  end
end
