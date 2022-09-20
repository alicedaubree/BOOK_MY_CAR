class CarsController < ApplicationController
  before_action :set_car, only: [:show, :edit, :update, :destroy]

  def index
    if params[:query].present?
      sql_query = "cars.title @@ :query \
      OR cars.description @@ :query"
      @cars = Car.joins(:user).where(sql_query, query: "%#{params[:query]}%")
    else
      @cars = Car.all
    end
    @markers = @cars.geocoded.map do |car|
      {
        lat: car.latitude,
        lng: car.longitude,
        info_window: render_to_string(partial: "info_window", locals: {car: car}), image_url: helpers.asset_url("pin_map.png"),
      }
    end
  end

  def new
    @car = Car.new
  end

  def create
    @car = Car.new(car_params)
    @car.user = current_user
    @car.address = params[:car][:address]
    if @car.valid?
      @car.save
      redirect_to cars_path(@car)
    else
      render :new
    end
  end

  def show
    @marker_car = Car.where(id: @car.id)
    @markers = @marker_car.geocoded.map do |car|
      {
        lat: car.latitude,
        lng: car.longitude,
        info_window: render_to_string(partial: "info_window", locals: {car: car}), image_url: helpers.asset_url("pin_map.png"),
      }
    end
  end

  def edit
  end

  def update
    @car.update(car_params)
    redirect_to car_path(@car)
  end

  def destroy
    @car.destroy
    # No need for app/views/restaurants/destroy.html.erb
    redirect_to root_path, status: :see_other
  end

  private

  def car_params
    params.require(:car).permit(:title, :description, :available_for, :type_of_car, photos: [])
  end

  def set_car
    @car = car.find(params[:id])
  end

end


# class PlacesController < ApplicationController

#   before_action :set_place, only: [:show, :edit, :update, :destroy]



#   def index
#     if params[:query].present?
#       sql_query = "places.title @@ :query \
#       OR places.description @@ :query \
#       OR users.authority_name @@ :query \
#       OR places.address @@ :query \
#       OR places.type_of_place @@ :query \
#       OR activities.name @@ :query"
#       @places = Place.joins(:user).joins(:place_activities).joins(:activities).where(sql_query, query: "%#{params[:query]}%")
#       @places_index = @places.uniq
#     else
#       @places = Place.all
#     end
#     @markers = @places.geocoded.map do |place|
#       {
#         lat: place.latitude,
#         lng: place.longitude,
#         info_window: render_to_string(partial: "info_window", locals: {place: place}), image_url: helpers.asset_url("pin_map.png"),
#       }
#     end
#   end

#   def new
#     @place = Place.new
#     @activities_temp = Activity.where(activity_available_for: "⌛ Location temporaire")
#     @activities_long = Activity.where(activity_available_for: "🏗️ Projet long terme")
#     @placeholder = "Description du lieu :\n\n\n\n\nCe lieu est disponible à la location pour les évènements suivants :\n\n\n\n\nNous sommes intéressés par les projets d'aménagement suivants :\n\n\n\n\n"
#   end

#   def create
#     @place = Place.new(place_params)
#     @place.user = current_user
#     @place.address = params[:place][:address]
#     if @place.valid?
#       @place.save
#       redirect_to places_path(@place)
#     else
#       render :new
#     end
#     params_place_activities = params[:place][:activities]
#     params_place_activities.select! do |p|
#       p != ""
#     end
#     params_place_activities.each do |activity|
#       place_act = PlaceActivity.new(activity_id: activity, place_id: @place.id)
#       place_act.save!
#     end
#   end

#   def show
#     @marker_place = Place.where(id: @place.id)
#     @markers = @marker_place.geocoded.map do |place|
#       {
#         lat: place.latitude,
#         lng: place.longitude,
#         info_window: render_to_string(partial: "info_window", locals: {place: place}), image_url: helpers.asset_url("pin_map.png"),
#       }
#     end
#   end

#   def edit
#     @activities_temp = Activity.where(activity_available_for: "⌛ Location temporaire")
#     @activities_long = Activity.where(activity_available_for: "🏗️ Projet long terme")
#   end

#   def update
#     @place.update(place_params)
#     params_place_activities = params[:place][:activities]
#     params_place_activities.select! do |p|
#       p != ""
#     end
#     @place.place_activities.destroy_all
#     params_place_activities.each do |activity|
#       place_act = PlaceActivity.new(activity_id: activity, place_id: @place.id)
#       place_act.save!
#     end
#     redirect_to place_path(@place)
#   end

#   def destroy
#     @place.destroy
#     # No need for app/views/restaurants/destroy.html.erb
#     redirect_to root_path, status: :see_other
#   end

#   private

#   def place_params
#     params.require(:place).permit(:title, :description, :available_for, :type_of_place, photos: [])
#   end

#   def set_place
#     @place = Place.find(params[:id])
#   end
# end
