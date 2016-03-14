class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.references  :listing
      t.string      :line_1
      t.string      :line_2
      t.string      :city
      t.string      :state
      t.string      :zipcode
      t.string      :country
      t.float       :latitude
      t.float       :longitude

      t.timestamps
    end

  end
end
