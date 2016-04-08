class Address < ActiveRecord::Base
include PgSearch
  belongs_to :listing
  has_many :details
  geocoded_by :full_street_address
  after_validation :geocode, :reverse_geocode
  reverse_geocoded_by :latitude, :longitude do |obj, results|
    if geo = results.first
      obj.line_1  = geo.street_address
      obj.city    = geo.city
      obj.state   = geo.state
      obj.zipcode = geo.postal_code
      obj.country = geo.country_code
    end
  end
  pg_search_scope :address_search, :associated_against => {
    :listing => :category
  }

  def full_street_address
  	if line_1.present? && zipcode.present? || city.present?
  		return line_1 + ', ' + city + ', ' + state + ', ' + zipcode 
  	else
  		nil
  	end
  end

end


