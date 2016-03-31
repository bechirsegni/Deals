class AddAttachmentCoverPhotoToDeals < ActiveRecord::Migration
  def self.up
    change_table :deals do |t|
      t.attachment :cover_photo
    end
  end

  def self.down
    remove_attachment :deals, :cover_photo
  end
end
