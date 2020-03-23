class Listing < ApplicationRecord
  URLREGEXP = /^https:\/\/(airbnb.com\/h\/|abnb.me|www.airbnb.com\/rooms)/
  belongs_to :user

  validates :uid, uniqueness: { scope: :user_id }

  def market_address
    [market, country, state].join(', ')
  end
end
