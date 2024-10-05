class CreatePropositions < ActiveRecord::Migration[7.2]
  def change
    create_table :propositions do |t|
      t.string :body
      t.references :author, null: false, foreign_key: {to_table: :users}

      t.timestamps
    end
  end
end
