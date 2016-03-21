class Address < ActiveRecord::Base
include PgSearch
  belongs_to :listing
  geocoded_by :full_street_address
  after_validation :geocode


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


