class Deal < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many   :reviews
  ratyrate_rateable "price"
  acts_as_votable
end
