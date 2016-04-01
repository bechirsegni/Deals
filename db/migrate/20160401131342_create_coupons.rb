class CreateCoupons < ActiveRecord::Migration[5.0]
  def change
    create_table :coupons do |t|
      t.string :number
      t.references :deal
      t.integer :user_id

      t.timestamps
    end
  end
end
