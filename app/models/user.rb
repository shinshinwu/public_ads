class User < ActiveRecord::Base
  acts_as_messageable

  DESIGNER                = "User::Designer"
  MARKETER                = "User::Marketer"
  CURATOR                 = "User::Curator"
  VENDOR                  = "User::Vender"

  self.inheritance_column = 'user_type'

  has_many    :listings
  has_many    :send_inquiries, class_name: "Inquiry", foreign_key: "sender_id"
  has_many    :received_inquiries, class_name: "Inquiry", foreign_key: "recipient_id"
  has_many    :payment_transactions, class_name: "Transaction", foreign_key: "buyer_id"
  has_many    :earning_transactions, class_name: "Transaction", foreign_key: "seller_id"

  validates :email,    :presence => true,
                       :uniqueness => true,
                       :format => { :with => /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  has_secure_password

  # returns an array of valid user types hash
  def self.user_types
    ["designer" => DESIGNER, "marketer" => MARKETER, "curator" => CURATOR, "vendor" => VENDOR]
  end

  def self.user_form_selections
    user_types.map{|h| [h.keys.map(&:titleize), h.values]}.flatten(1).transpose
  end

  def designer?
    user_type == DESIGNER
  end

  def marketer?
    user_type == MARKETER
  end

  def curator?
    user_type == CURATOR
  end

  def vendor?
    user_type == VENDOR
  end

  def name
    if first_name.present? && last_name.present?
      return first_name + " " + last_name
    else
      return email[/[^@]+/] #first part of the email
    end
  end

  def mailboxer_email(object)
    return email
  end

  def have_contacted_listing?(listing)
    send_inquiries.where(listing: listing).present?
  end

  def inquired_listings
    Listing.where(id: send_inquiries.pluck(:listing_id))
  end

end