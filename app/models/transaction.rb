class Transaction < ActiveRecord::Base
  belongs_to :listing
  belongs_to :seller, class_name: "User", foreign_key: "seller_id"
  belongs_to :buyer, class_name: "User", foreign_key: "buyer_id"
  belongs_to :inquiry

  def create_customer!(token:nil, user:nil)
    Stripe.api_key = ENV["STRIPE_API_KEY"]
    begin
      customer = Stripe::Customer.create(
        source: token,
        email: user.email,
        description: "Public Ads"
      )
    rescue => e
      self.last_cc_error = e
      self.save!
      raise e
    end
    user.customer_id = customer.id
    user.save!
    return customer
  end

  def charge_customer!(user:nil, listing:nil)
    Stripe.api_key = ENV["STRIPE_API_KEY"]
    begin
      charge = Stripe::Charge.create(
        amount: (listing.base_amount*100.to_f).to_i,
        currency: "usd",
        customer: user.customer_id,
        description: "Public Ads Listing ID #{listing.id}"
      )
    rescue => e
      self.last_cc_error = e
      self.save!
      raise e
    end

    self.charge_id = charge.id
    self.save!
    return self
  end
end