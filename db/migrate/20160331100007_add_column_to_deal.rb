class AddColumnToDeal < ActiveRecord::Migration[5.0]
  def change
    add_column :deals, :wifi, :boolean
    add_column :deals, :parking, :boolean
    add_column :deals, :music, :boolean
    add_column :deals, :smoking, :boolean
  end
end
