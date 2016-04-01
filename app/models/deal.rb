class Deal < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  has_attached_file :cover_photo, styles: { large: "1400x480>", medium: "800x533>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :cover_photo, content_type: /\Aimage\/.*\Z/

  validates :cover_photo, attachment_presence: true
  validates_with AttachmentPresenceValidator, attributes: :cover_photo
  validates_with AttachmentSizeValidator, attributes: :cover_photo, less_than: 2.megabytes



  belongs_to :user
  belongs_to :category
  has_many   :reviews

  ratyrate_rateable "price"
  acts_as_votable

  def percentage
    prix_after.to_f / prix_before.to_f * 100
  end

  mapping do
    indexes :id, index: :not_analyzed
    indexes :title
    indexes :about
    indexes :prix_before
    indexes :prix_after
    indexes :address
    indexes :timing
    indexes :email
    indexes :deadline
    indexes :menu
    indexes :conditions
    indexes :reservation
    indexes :city
    indexes :business
    indexes :website
    indexes :phone
    indexes :facebook
    indexes :instagram
    indexes :wifi, type: 'boolean'
    indexes :parking, type: 'boolean'
    indexes :music, type: 'boolean'
    indexes :smoking, type: 'boolean'
    indexes :category, type: 'nested' do
      indexes :id,   type: 'integer'
      indexes :name, type: 'string', index: :not_analyzed
      indexes :icon, type: 'string', index: :not_analyzed
    end
    indexes :user, type: 'nested' do
      indexes :id,   type: 'integer'
      indexes :first_name, type: 'string', index: :not_analyzed
      indexes :last_name, type: 'string', index: :not_analyzed
    end
    indexes :reviews, type: 'nested' do
      indexes :id,   type: 'integer'
      indexes :body, type: 'string', index: :not_analyzed
      end
  end


  def as_indexes_json(options = {})
    self.as_json(only: [:id, :about, :business,:title,:prix_after,:address,:city,:cover_photo],
                 include: {
                     usery:  { only: [:id, :first_name, :last_name] },
                     category: { only: [:id, :name, :icon] },
                     reviews:{only: [:id, :body]},
                 })
  end

  class << self
    def custom_search(query)
      __elasticsearch__.search(query: multi_match_query(query))
    end

    def multi_match_query(query)
      {
          multi_match: {
              query: query,
              type: "best_fields", # possible values "most_fields", "phrase", "phrase_prefix", "cross_fields"
              fields: ["title^9", "about^8", "business", "city^7", "category.name, :percentage, :cover_photo"],
              operator: "and"
          }
      }
    end
  end



  class RelationError < StandardError
    def initialize(msg = "That Relationship Type doesn't exist")
      super(msg)
    end
  end

  def add_many(type, data)
    if type.in? ['Category', 'User', 'Review']
      self.send("#{type.downcase.pluralize}=", data.map do |g|
        type.classify.constantize.where(name: g).first_or_create!
      end)
    else
      raise RelationError
    end
  end
end
