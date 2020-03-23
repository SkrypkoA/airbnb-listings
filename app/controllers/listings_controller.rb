class ListingsController < ApplicationController
  require 'airbnb_service'
  def index
    @listings = current_user.listings
  end

  def new
    url = params[:url]
    unless Listing::URLREGEXP.match?(url)
      flash[:danger] = 'Invalid link provided!'
      return redirect_to listings_path
    end
    listing_id = AirbnbService::Client.listing_id_by_url(url)

    if listing_id.blank?
      flash[:danger] = 'Listing not found!'
      return redirect_to listings_path
    end

    client = AirbnbService::Client.new(ENV['CLIENT_ID'])
    listing_json = client.listing(listing_id)

    if listing_json.has_key?(:error)
      flash[:danger] = listing_json[:error]
      return  redirect_to listings_path
    end

    listing_params_hash = listing_json.deep_symbolize_keys[:listing].slice(
        :name,
        :medium_url,
        :market,
        :price_formatted,
        :city,
        :country,
        :state,
        :created_at,
        :updated_at
    )
    @listing = Listing.new(listing_params_hash.merge(entire_url: url, uid: listing_id))
  end

  def create
    @listing = current_user.listings.new(listing_params)
    if @listing.save
      redirect_to listings_path
    else
      flash[:danger] = @listing,errors.full_messages,join(', ')
      render :new
    end
  end
  
  private
  
  def listing_params
    params.require(:listing).permit(
      :entire_url,
      :uid,
      :name,
      :medium_url,
      :market,
      :price_formatted,
      :city,
      :country,
      :state
    )
  end
end
