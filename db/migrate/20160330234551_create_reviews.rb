class CreateReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
      t.text :body
      t.references :deal, foreign_key: true
      t.integer :user_id
      t.timestamps
    end
  end
end
