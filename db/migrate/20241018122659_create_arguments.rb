class CreateArguments < ActiveRecord::Migration[7.2]
  def change
    create_table :arguments do |t|
      t.text :body
      t.boolean :side, default: false
      t.references :proposition, null: false, foreign_key: true
      t.references :author, null: false, foreign_key: {to_table: :users}

      t.timestamps
    end
  end
end
