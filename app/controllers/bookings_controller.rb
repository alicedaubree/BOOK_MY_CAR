class BookingsController < ApplicationController
    before_action :set_car, only: %i[new create destroy]

    def create
      @booking = Booking.new(booking_params)
      @booking.car = @car
      @booking.user = current_user
      if @booking.save!
        redirect_to car_path(@car)
      else
        render :new
      end
    end

    def destroy
      @booking = booking.find(params[:id])
      @booking.destroy
      redirect_to car_path(@car), status: :see_other
    end

    private

    def booking_params
      params.require(:booking).permit(:total_price, :start_date, :end_date, :user_id, :car_id)
    end

    def set_car
      @car = Car.find(params[:car_id])
    end
end
