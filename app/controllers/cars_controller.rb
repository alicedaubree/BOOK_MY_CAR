class CarsController < ApplicationController
  before_action :set_car, only: [:show]

  def index
    if params[:query].present?
      sql_query = "cars.title @@ :query \
      OR cars.address @@ :query \
      OR cars.description @@ :query"
      @cars = Car.where(sql_query, query: "%#{params[:query]}%")
      # If we want to use an another table like users.first_name
      # @cars = Car.joins(:user).where(sql_query, query: "%#{params[:query]}%")
    else
      @cars = Car.all
    end
    @markers = @cars.geocoded.map do |car|
      {
        lat: car.latitude,
        lng: car.longitude
      }
    end
  end

  def show
    @booking = Booking.new
    @marker_car = Car.where(id: @car.id)
    @markers = @marker_car.geocoded.map do |car|
      {
        lat: car.latitude,
        lng: car.longitude,
        info_window: render_to_string(partial: "info_window", locals: {car: car}), image_url: helpers.asset_url("pin_map.png"),
      }
    end
  end

  private

  # def car_params
  #   params.require(:car).permit(:title, :description, :available_for, :type_of_car, photos: [])
  # end

  def set_car
    @car = Car.find(params[:id])
  end

end
