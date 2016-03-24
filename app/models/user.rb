class User < ActiveRecord::Base
  acts_as_messageable

  has_many    :listings
  has_many    :send_messages, class_name: "Message", foreign_key: "sender_id"
  has_many    :received_messages, class_name: "Message", foreign_key: "recipient_id"
  has_many    :payment_transactions, class_name: "Transaction", foreign_key: "buyer_id"
  has_many    :earning_transactions, class_name: "Transaction", foreign_key: "seller_id"

  validates :email,    :presence => true,
                       :uniqueness => true,
                       :format => { :with => /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  has_secure_password

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

end