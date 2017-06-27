class Listing < ActiveRecord::Base
  belongs_to :neighborhood
  belongs_to :host, :class_name => "User"
  has_many :reservations
  has_many :reviews, :through => :reservations
  has_many :guests, :class_name => "User", :through => :reservations

  validates :address,
            :listing_type,
            :title,
            :description,
            :price,
            :neighborhood, presence: true

  before_create :user_update
  after_destroy :user_reset

  def average_review_rating
    self.reviews.map(&:rating).reduce(:+) / self.reviews.count.to_f
  end

  private
    def user_update
      self.host.update(host: true)
    end

    def user_reset
      self.host.update(host: false) if self.host.listings.blank?
    end

end
