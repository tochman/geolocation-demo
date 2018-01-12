class RestaurantsController < ApplicationController
  before_action :coordinates, only: :index

  def index
    @restaurants = Restaurant.near([@coordinates[:latitude], @coordinates[:longitude]], 50)
  end


  private
  def coordinates
    @coordinates = {}
    if cookies['geocoderLocation'].present?
      @coordinates = JSON.parse(cookies['geocoderLocation']).to_hash.symbolize_keys
      @geocoded = true
    else
      #@coordinates = {latitude: nil,
      #                longitude: nil}
      @geocoded = false
    end
  end
end
