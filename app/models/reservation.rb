class Reservation < ActiveRecord::Base
  belongs_to :listing
  belongs_to :guest, :class_name => "User"
  has_one :review

  validates :checkin, :checkout,
    presence: true
  validate :is_own_listing

  private
    def is_own_listing
      if self.guest_id == self.listing.host_id
        errors.add(:guest_id, "can't reserve their own listing")
      end
    end

    def available
      # ... this shit is too hard.
    end
end
