class Listing < ActiveRecord::Base
  include PgSearch
  belongs_to :user
  has_one    :address
  has_many   :messages
  has_many   :transactions

  has_attached_file :photo, default_url: :set_default_url_on_ad_type
  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\Z/

  def renewal_period_days
    case charge_frequency
    when "daily"
      return 1
    when "weekly"
      return 7
    when "monthly"
      return 30
    when "yearly"
      return 365
    end
  end

  def renewal_period_label
    case charge_frequency
    when "daily"
      return "/ day"
    when "weekly"
      return "/ week"
    when "monthly"
      return "/ mo"
    when "yearly"
      return "/ yr"
    end
  end

  def area
      return width * height unless !width || !height
  end

  private
  def set_default_url_on_ad_type
    case self.category
    when "Billboard"
      "public-ad-sample-2.jpg"
    when "Bus Stop"
      "bus-stop-poster.jpg"
    when "Bench Ad"
      "bench-ad-sample.jpg"
    else
      "publicad-logo-lg.png"
    end
  end
end