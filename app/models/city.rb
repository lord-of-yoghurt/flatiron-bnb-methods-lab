class City < ActiveRecord::Base

  has_many :neighborhoods
  has_many :listings, :through => :neighborhoods

  # given a start date and an end date, return an array of
  # available listings for a particular city.
  def city_openings(start_date, end_date)
    self.listings.select do |l|
      l.reservations.where(
        "checkin <= ? AND checkout >= ?", end_date, start_date
      ).blank?
    end
  end

  # iterate over listings for each city with max_by,
  # get the city's listings, collect the count of each
  # listing's reservations, sum it up, divide it by the
  # number of listings. max_by will return the one object
  # with the max ratio of reservations / listings
  def self.highest_ratio_res_to_listings
    self.all.max_by do |c|
      listings = c.listings
      listings.map do |l|
        l.reservations.count
      end.reduce(:+) / listings.count.to_f
    end
  end

  def self.most_res
    self.all.max_by do |c|
      c.listings.map{|l| l.reservations.count}.reduce(:+)
    end
  end
end
