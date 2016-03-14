class Address < ActiveRecord::Base
  belongs_to :listing
  geocoded_by :full_street_address
  after_validation :geocode

  def full_street_address
  	if line_1.present? && zipcode.present? || city.present?
  		return line_1 + ', ' + city + ', ' + state + ', ' + zipcode 
  	else
  		nil
  	end
  end

end


