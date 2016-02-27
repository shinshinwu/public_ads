class Listing < ActiveRecord::Base
  belongs_to :user
  has_one    :address
  has_many   :messages

  has_attached_file :photo, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\Z/

  validates_attachment_presence :photo
  validates_attachment_size :photo, :less_than => 2.megabytes
  validates_attachment :photo,
  content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] }
end