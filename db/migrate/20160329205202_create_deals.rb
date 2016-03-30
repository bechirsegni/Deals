class CreateDeals < ActiveRecord::Migration[5.0]
  def change
    create_table :deals do |t|
      t.string :business
      t.string :title
      t.text :about
      t.string :email
      t.string :phone
      t.string :address
      t.string :city
      t.integer :prix_before
      t.integer :prix_after
      t.datetime :deadline
      t.text :menu
      t.text :conditions
      t.boolean :reservation
      t.string :timing
      t.string :website
      t.string :facebook
      t.string :instagram
      t.integer :user_id
      t.integer :category_id

      t.timestamps
    end
  end
end
