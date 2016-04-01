class Deal < ApplicationRecord
  has_attached_file :cover_photo, styles: { large: "1400x480>", medium: "800x533>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :cover_photo, content_type: /\Aimage\/.*\Z/

  validates :cover_photo, attachment_presence: true
  validates_with AttachmentPresenceValidator, attributes: :cover_photo
  validates_with AttachmentSizeValidator, attributes: :cover_photo, less_than: 2.megabytes


  belongs_to :user
  belongs_to :category
  has_many   :reviews
  has_many   :coupons

  ratyrate_rateable "price"
  acts_as_votable

  def percentage
    (prix_after.to_f  / prix_before.to_f * 100).round
  end
end
