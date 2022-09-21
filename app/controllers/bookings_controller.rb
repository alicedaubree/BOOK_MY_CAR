class BookingsController < ApplicationController
    before_action :set_car, only: %i[new create destroy]

    def create
      @booking = Booking.new(booking_params)
      @booking.car = @car
      @booking.user = current_user
      if @booking.save!
        redirect_to profile_path
      else
        render :new
      end
    end

    def destroy
      @booking = Booking.find(params[:id])
      @booking.destroy
      redirect_to profile_path, status: :see_other
    end

    private

    def booking_params
      params.require(:booking).permit(:total_price, :start_date, :end_date, :user_id, :car_id)
    end

    def set_car
      @car = Car.find(params[:car_id])
    end
end
