class Neighborhood < ActiveRecord::Base

  belongs_to :city
  has_many :listings

  def neighborhood_openings(start_date, end_date)
    self.listings.select do |l|
      l.reservations.where(
        "checkin <= ? AND checkout >= ?", end_date, start_date
      ).blank?
    end
  end

  def self.highest_ratio_res_to_listings
    self.all.max_by do |n|
      listings = n.listings
      if !listings.blank?
        listings.collect do |l|
          l.reservations.count
        end.reduce(:+) / listings.count.to_f
      else
        0
      end
    end
  end

  def self.most_res
    self.all.max_by do |n|
      if !n.listings.blank?
        n.listings.collect do |l|
          l.reservations.count
        end.reduce(:+)
      else
        0
      end
    end
  end
end
